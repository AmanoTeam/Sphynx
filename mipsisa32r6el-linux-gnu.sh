#!/bin/bash

declare packages=(
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/libc6-mipsr6el-cross_2.28-7cross2_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/linux-libc-dev-mipsr6el-cross_4.19.16-1cross2_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-mipsen/libc6-dev-mipsr6el-cross_2.28-7cross2_all.deb'
)

declare extra_configure_flags='--with-arch-32=mips32r6 --with-tune-32=mips32r6 --with-arch-64=mips64r6 --with-tune-64=mips64r6'

declare triplet='mipsisa32r6el-unknown-linux-gnu'
