#!/bin/sh

export PATH="/bin:/sbin:/usr/bin:/usr/sbin"

mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev
mkdir /dev/pts && mount -t devpts devpts /dev/pts

touch /run/loop.lock

CMDLINE=$(cat /proc/cmdline)

for i in ${CMDLINE}; do
  test "x${i:0:8}" == "xSTORAGE=" && STORAGE=${i:8}
done

mount -t ext4 ${STORAGE}1 /boot
source /boot/machine.conf

cp /boot/authorized_keys ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

hostname ${HOSTNAME}

ifconfig lo up
ifconfig ${IFACE} ${IADDR} netmask ${IMASK}

ip route add default via ${IGWAY}

dropbear -R -p ${IPORT} &> /dev/null
SSHDPID=$(cat /var/run/dropbear.pid)

while [ -f /run/loop.lock ]; do
  sleep 1
done

kill -9 ${SSHDPID} && sleep 1

cryptsetup luksOpen ${STORAGE}2 crypt --key-file /tmp/key.hdd
vgchange -ay vg0
vgmknodes

mount -t squashfs /dev/mapper/vg0-rootfs /mnt/ro
mount -t ext4 /dev/mapper/vg0-data /mnt/rw

mount -t aufs none /newroot -o br=/mnt/data:/mnt/rootfs

ip addr flush dev ${IFACE}
ifconfig ${IFACE} down

ip addr flush dev lo
ifconfig lo down

ip route flush table all

umount /dev/pts && rmdir /dev/pts
umount /proc /sys /dev

exec /bin/busybox switch_root /newroot /sbin/init ${CMDLINE}
