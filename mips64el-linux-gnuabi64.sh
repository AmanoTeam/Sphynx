#!/bin/bash

declare packages=(
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/libc6-mips64el-cross_2.31-11cross1_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/linux-libc-dev-mips64el-cross_5.10.28-1cross1_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/libc6-dev-mips64el-cross_2.31-11cross1_all.deb'
)

declare extra_configure_flags='--with-mips-plt --with-arch-64=mips64r2 --with-madd4=no --with-arch-32=mips32r2 --with-fp-32=xx --disable-libsanitizer'

declare triplet='mips64el-unknown-linux-gnuabi64'
