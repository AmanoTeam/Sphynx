#!/bin/bash

declare packages=(
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-ports/libc6-x32-cross_2.28-7cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-ports/linux-libc-dev-x32-cross_4.19.20-1cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base-ports/libc6-dev-x32-cross_2.28-7cross1_all.deb'
)

declare extra_configure_flags='--with-abi=mx32'

declare triplet='x86_64-unknown-linux-gnux32'
