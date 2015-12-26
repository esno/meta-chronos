# chronoslinux

an embedded linux distribution based on the [openembedded project](http://openembedded.org).
It's intended to be a lightweight distro for several use-cases.

# supported hardware

## amd64

* qemu/kvm

# how it works

## setup oe

    $ git clone http://git.openembedded.org/openembedded-core
    
    $ cd openembedded-core
    $ git clone http://git.openembedded.org/bitbake
    $ git clone http://git.openembedded.org/meta-openembedded

## setup chronos

    $ git clone https://github.com/esno/meta-chronos.git

## initialize build environment

    $ TEMPLATECONF=meta-chronos/conf/samples source  oe-init-build-env [<destination>]
