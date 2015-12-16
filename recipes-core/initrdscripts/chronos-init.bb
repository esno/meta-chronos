SUMMARY = "chronos initram script"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = " \
  file://init.sh \
  "

inherit allarch

S = "${WORKDIR}"

RDEPENDS_${PN} = " \
  cryptsetup \
  lvm2 \
  iproute2 \
  packagegroup-core-ssh-dropbear \
  "

do_install() {
  install -m 0755 ${WORKDIR}/init.sh ${D}/init

  install -m 0755 -d ${WORKDIR}/run/lvm
  install -m 0755 -d ${WORKDIR}/run/lock/lvm

  install -m 0700 -d ${WORKDIR}${ROOT_HOME}/.ssh

  install -m 0755 -d ${WORKDIR}/mnt/ro
  install -m 0755 -d ${WORKDIR}/mnt/rw
  install -m 0755 -d ${WORKDIR}/newroot
}

FILES_${PN} += " \
  /init \
  /run/lvm \
  /run/lock/lvm \
  ${ROOT_HOME}/.ssh \
  /mnt/ro \
  /mnt/rw \
  /newroot \
  "
