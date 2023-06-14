#!/bin/bash

declare packages=(
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-ports/libc6-riscv64-cross_2.28-7cross1_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-ports/linux-libc-dev-riscv64-cross_4.19.20-1cross1_all.deb'
	'https://web.archive.org/web/0if_/https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-ports/libc6-dev-riscv64-cross_2.28-7cross1_all.deb'
)

declare extra_configure_flags='--with-arch=rv64imafdc --with-abi=lp64d'

declare triple='riscv64-linux-gnu'
