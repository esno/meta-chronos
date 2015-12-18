SUMMARY = "chronos initram install script"

require recipes-core/initrdscripts/include/chronos.inc

SRC_URI += " \
  file://init.sh \
  "

RDEPENDS_${PN} += " \
  e2fsprogs \
  "

do_install() {
  install -m 0755 ${WORKDIR}/init.sh ${D}/init
}

FILES_${PN} += " \
  /init \
  "
