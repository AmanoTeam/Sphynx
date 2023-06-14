#!/bin/bash

declare packages=(
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-ports/libc6-dev-ppc64-cross_2.28-7cross1_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-ports/libc6-ppc64-cross_2.28-7cross1_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-ports/linux-libc-dev-ppc64-cross_4.19.20-1cross1_all.deb'
)

declare extra_configure_flags=''

declare triple='powerpc64-linux-gnu'
