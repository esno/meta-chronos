PACKAGE_INSTALL = " \
        busybox \
        udev \
        base-passwd \
        gnupg \
        mdadm \
        lvm2 \
        cryptsetup \
        ${ROOTFS_BOOTSTRAP_INSTALL} \
        "

# Do not pollute the initrd image with rootfs features
IMAGE_FEATURES = ""

export IMAGE_BASENAME = "${PN}"
IMAGE_LINGUAS = ""

LICENSE = "MIT"

IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"
inherit core-image

BAD_RECOMMENDATIONS += "busybox-syslog"
