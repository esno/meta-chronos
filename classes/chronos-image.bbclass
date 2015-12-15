# chronos image class

IMAGE_LOGIN_MANAGER = "shadow"

inherit core-image distro_features_check

IMAGE_FEATURES += " \
  read-only-rootfs \
  "

IMAGE_INSTALL += " \
  packagegroup-core-boot \
  packagegroup-core-ssh-dropbear \
  ${ROOTFS_PKGMANAGE_BOOTSTRAP} \
  ${CORE_IMAGE_EXTRA_INSTALL} \
  "

INAGE_INSTALL += " \
  shadow \
  "
