COMPATIBLE_MACHINE_amd64 = "amd64"

KMACHINE_amd64 = "amd64"
KBRANCH_amd64 = "standard/base"
SRCREV_machine_amd64 ?= "2c30f87db7824e90b0b096eee3a5b7f93c84b079"

KERNEL_FEATURES_append_amd64 = " cfg/virtio.scc cfg/paravirt_kvm.scc"
