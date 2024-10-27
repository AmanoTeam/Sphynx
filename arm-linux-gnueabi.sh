#!/bin/bash

declare packages=(
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-dev-armel-cross_2.28-7cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-armel-cross_2.28-7cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/linux-libc-dev-armel-cross_4.19.20-1cross1_all.deb'
)

declare extra_configure_flags='--with-arch=armv5te --with-float=soft'

declare triplet='arm-unknown-linux-gnueabi'
