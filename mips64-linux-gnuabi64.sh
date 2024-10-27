#!/bin/bash

declare packages=(
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/linux-libc-dev-mips64-cross_4.19.16-1cross2_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/libc6-dev-mips64-cross_2.28-7cross2_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/libc6-mips64-cross_2.28-7cross2_all.deb'
)

declare extra_configure_flags='--with-mips-plt --with-arch-64=mips64r2'

declare triplet='mips64-unknown-linux-gnuabi64'
