#!/bin/bash

declare packages=(
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-ppc64el-cross_2.28-7cross1_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-dev-ppc64el-cross_2.28-7cross1_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/linux-libc-dev-ppc64el-cross_4.19.20-1cross1_all.deb'
)

declare extra_configure_flags='--enable-secureplt --with-cpu=power8 --with-long-double-128'

declare triple='powerpc64le-linux-gnu'
