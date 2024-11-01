#!/bin/bash

declare packages=(
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-dev-arm64-cross_2.28-7cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-arm64-cross_2.28-7cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/linux-libc-dev-arm64-cross_4.19.20-1cross1_all.deb'
)

declare extra_configure_flags='--enable-fix-cortex-a53-843419'

declare triplet='aarch64-unknown-linux-gnu'
