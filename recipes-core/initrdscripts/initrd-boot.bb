SUMMARY = "chronos initram script"

require recipes-core/initrdscripts/include/chronos.inc

SRC_URI += " \
  file://init.sh \
  "

RDEPENDS_${PN} += " \
  iproute2 \
  packagegroup-core-ssh-dropbear \
  "

do_install() {
  install -m 0755 ${WORKDIR}/init.sh ${D}/init

  install -m 0700 -d ${WORKDIR}${ROOT_HOME}/.ssh
}

FILES_${PN} += " \
  /init \
  ${ROOT_HOME}/.ssh \
  "
