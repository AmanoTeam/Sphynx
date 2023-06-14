#!/bin/bash

declare packages=(
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-ports/libc6-dev-hppa-cross_2.28-7cross1_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-ports/libc6-hppa-cross_2.28-7cross1_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-ports/linux-libc-dev-hppa-cross_4.19.20-1cross1_all.deb'
)

declare extra_configure_flags=''

declare triple='hppa-linux-gnu'
