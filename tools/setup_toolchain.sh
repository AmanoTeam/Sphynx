#!/bin/bash

set -eu

declare -r SPHYNX_HOME='/tmp/sphynx-toolchain'

if [ -d "${SPHYNX_HOME}" ]; then
	PATH+=":${SPHYNX_HOME}/bin"
	export SPHYNX_HOME \
		PATH
	return 0
fi

declare -r SPHYNX_TAG="$(jq --raw-output '.tag_name' <<< "$(curl --retry 10 --retry-delay 3 --silent --url 'https://api.github.com/repos/AmanoTeam/Sphynx/releases/latest')")"
declare -r SPHYNX_TARBALL='/tmp/raiden.tar.xz'
declare -r SPHYNX_URL="https://github.com/AmanoTeam/Sphynx/releases/download/${SPHYNX_TAG}/x86_64-linux-gnu.tar.xz"

curl --retry 10 --retry-delay 3 --silent --location --url "${SPHYNX_URL}" --output "${SPHYNX_TARBALL}"
tar --directory="$(dirname "${SPHYNX_TARBALL}")" --extract --file="${SPHYNX_TARBALL}"

rm "${SPHYNX_TARBALL}"

mv '/tmp/sphynx' "${SPHYNX_HOME}"

PATH="${SPHYNX_HOME}/bin:${PATH}"

export SPHYNX_HOME \
	PATH
