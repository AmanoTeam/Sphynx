#!/bin/bash

declare packages=(
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-dev-mips-cross_2.28-7cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-mips-cross_2.28-7cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/linux-libc-dev-mips-cross_4.19.20-1cross1_all.deb'
)

declare extra_configure_flags='--with-arch-32=mips32r2 --with-fp-32=xx --with-lxc1-sxc1=no'

declare triplet='mips-unknown-linux-gnu'
