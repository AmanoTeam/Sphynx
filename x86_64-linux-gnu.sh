#!/bin/bash

declare packages=(
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-amd64-cross_2.28-7cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/linux-libc-dev-amd64-cross_4.19.20-1cross1_all.deb'
	'https://deb.debian.org/debian/pool/main/c/cross-toolchain-base/libc6-dev-amd64-cross_2.28-7cross1_all.deb'
)

declare extra_configure_flags=''

declare triplet='x86_64-unknown-linux-gnu'
