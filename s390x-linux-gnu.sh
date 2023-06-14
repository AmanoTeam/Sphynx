#!/bin/bash

declare packages=(
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-dev-s390x-cross_2.28-7cross1_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-s390x-cross_2.28-7cross1_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/linux-libc-dev-s390x-cross_4.19.20-1cross1_all.deb'
)

declare extra_configure_flags='--with-arch=z196 --with-long-double-128'

declare triple='s390x-linux-gnu'
