#!/bin/bash

declare packages=(
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/libc6-mipsr6-cross_2.28-7cross2_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/linux-libc-dev-mipsr6-cross_4.19.16-1cross2_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/libc6-dev-mipsr6-cross_2.28-7cross2_all.deb'
)

declare extra_configure_flags='--with-arch-32=mips32r6 --with-tune-32=mips32r6 --with-arch-64=mips64r6 --with-tune-64=mips64r6'

declare triple='mipsisa32r6-unknown-linux-gnu'
