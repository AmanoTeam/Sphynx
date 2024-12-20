#!/bin/bash

declare packages=(
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-dev-armhf-cross_2.28-7cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-armhf-cross_2.28-7cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/linux-libc-dev-armhf-cross_4.19.20-1cross1_all.deb'
)

declare extra_configure_flags='--with-arch=armv7-a --with-fpu=vfpv3-d16 --with-float=hard --with-mode=thumb'

declare triplet='arm-unknown-linux-gnueabihf'
