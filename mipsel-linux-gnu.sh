#!/bin/bash

declare packages=(
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/libc6-mipsel-cross_2.31-11cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/linux-libc-dev-mipsel-cross_5.10.28-1cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/libc6-dev-mipsel-cross_2.31-11cross1_all.deb'
)

declare extra_configure_flags='--with-arch-32=mips32r2 --with-fp-32=xx --with-madd4=no --with-lxc1-sxc1=no --disable-libsanitizer'

declare triplet='mipsel-unknown-linux-gnu'
