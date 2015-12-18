LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

inherit allarch

S = "${WORKDIR}"

RDEPENDS_${PN} = " \
  cryptsetup \
  lvm2 \
  "

do_install() {
  install -m 0755 -d ${WORKDIR}/run/lvm
  install -m 0755 -d ${WORKDIR}/run/lock/lvm

  install -m 0755 -d ${WORKDIR}/mnt/ro
  install -m 0755 -d ${WORKDIR}/mnt/rw
  install -m 0755 -d ${WORKDIR}/newroot
}

FILES_${PN} = " \
  /run/lvm \
  /run/lock/lvm \
  /mnt/ro \
  /mnt/rw \
  /newroot \
  "
