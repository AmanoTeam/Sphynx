#!/bin/bash

set -eu

SPHYNX_TOOLCHAIN='/tmp/sphynx-toolchain'

if [ -d "${SPHYNX_TOOLCHAIN}" ]; then
	PATH+=":${SPHYNX_TOOLCHAIN}/bin"
	export SPHYNX_TOOLCHAIN \
		PATH
	return 0
fi

declare -r SPHYNX_CROSS_TAG="$(jq --raw-output '.tag_name' <<< "$(curl --retry 10 --retry-delay 3 --silent --url 'https://api.github.com/repos/AmanoTeam/Sphynx/releases/latest')")"
declare -r SPHYNX_CROSS_TARBALL='/tmp/sphynx.tar.xz'
declare -r SPHYNX_CROSS_URL="https://github.com/AmanoTeam/Sphynx/releases/download/${SPHYNX_CROSS_TAG}/x86_64-linux-gnu.tar.xz"

curl --retry 10 --retry-delay 3 --silent --location --url "${SPHYNX_CROSS_URL}" --output "${SPHYNX_CROSS_TARBALL}"
tar --directory="$(dirname "${SPHYNX_CROSS_TARBALL}")" --extract --file="${SPHYNX_CROSS_TARBALL}"

rm "${SPHYNX_CROSS_TARBALL}"

mv '/tmp/sphynx' "${SPHYNX_TOOLCHAIN}"

PATH+=":${SPHYNX_TOOLCHAIN}/bin"

export SPHYNX_TOOLCHAIN \
	PATH
