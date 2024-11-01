#!/bin/bash

declare packages=(
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-dev-i386-cross_2.28-7cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-i386-cross_2.28-7cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/linux-libc-dev-i386-cross_4.19.20-1cross1_all.deb'
)

declare extra_configure_flags='--with-arch-32=i686 --with-tune=generic'

declare triplet='i686-unknown-linux-gnu'
