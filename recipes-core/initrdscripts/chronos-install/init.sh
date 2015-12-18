#!/bin/sh

export PATH="/bin:/sbin:/usr/bin:/usr/sbin"

mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev
mkdir /dev/pts && mount -t devpts devpts /dev/pts

CMDLINE=$(cat /proc/cmdline)

for i in ${CMDLINE}; do
  test "x${i:0:8}" == "xSTORAGE=" && STORAGE=${i:8}
done

mount -t ext4 ${STORAGE}1 /boot

test -f /boot/machinie.conf && source /boot/machine.conf
test "x${HOSTNAME}" != "x" && hostname ${HOSTNAME}

parted ${STORAGE} mkpart primary ext2 512M 100%

dd if=/dev/urandom of=/boot/luks.key bs=512K count=1
cryptsetup luksFormat ${STORAGE}2 -c aes-xts-plain64:sha512 -s 512 --key-file /boot/luks.key
cryptsetup luksOpen ${STORAGE}2 crypt --key-file /tmp/luks.key

pvcreate /dev/mapper/crypt
vgcreate vg0 /dev/mapper/crypt

SIZE=$(du -Mks /boot/chronos.img | awk '{ print $1 }')
lvcreate -l${SIZE}M -n rootfs vg0
lvcreate -L100%FREE -n overlay vg0

mount -t squashfs /dev/mapper/vg0-rootfs /mnt/ro
mount -t ext4 /dev/mapper/vg0-data /mnt/rw

mount -t aufs none /newroot/etc -o br=/mnt/rw/system:/mnt/ro/etc
mount -t aufs none /newroot/home -o br=/mnt/rw/user:/mnt/ro/home

test "x${IFACE}" != "x" &&
echo "\
auto ${IFACE}\
iface ${IFACE} inet static\
  address ${IADDR}\
  netmask ${IMASK}\
  gateway ${IGWAY}" > /newroot/etc/network/interfaces

umount /dev/pts && rmdir /dev/pts
umount /proc /sys /dev

exec /bin/busybox switch_root /newroot /sbin/init ${CMDLINE}
