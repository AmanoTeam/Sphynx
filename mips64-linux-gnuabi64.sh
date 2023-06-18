#!/bin/bash

declare packages=(
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/linux-libc-dev-mips64-cross_4.19.16-1cross2_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/libc6-dev-mips64-cross_2.28-7cross2_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/libc6-mips64-cross_2.28-7cross2_all.deb'
)

declare extra_configure_flags='--with-mips-plt --with-arch-64=mips64r2'

declare triple='mips64-unknown-linux-gnuabi64'
