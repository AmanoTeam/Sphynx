#!/bin/bash

set -eu

declare -r revision="$(git rev-parse --short HEAD)"

declare -r current_source_directory="${PWD}"

declare -r toolchain_directory='/tmp/sphynx'

declare -r gmp_tarball='/tmp/gmp.tar.xz'
declare -r gmp_directory='/tmp/gmp-6.2.1'

declare -r mpfr_tarball='/tmp/mpfr.tar.xz'
declare -r mpfr_directory='/tmp/mpfr-4.2.0'

declare -r mpc_tarball='/tmp/mpc.tar.gz'
declare -r mpc_directory='/tmp/mpc-1.3.1'

declare -r binutils_tarball='/tmp/binutils.tar.xz'
declare -r binutils_directory='/tmp/binutils-2.41'

declare -r gcc_tarball='/tmp/gcc.tar.gz'
declare -r gcc_directory='/tmp/gcc-13.2.0'

declare -r optflags='-Os'
declare -r linkflags='-Wl,-s'

declare build_type="${1}"

if [ -z "${build_type}" ]; then
	build_type='native'
fi

declare is_native='0'

if [ "${build_type}" == 'native' ]; then
	is_native='1'
fi

declare OBGGCC_TOOLCHAIN='/tmp/obggcc-toolchain'
declare CROSS_COMPILE_TRIPLET=''

declare cross_compile_flags=''

if ! (( is_native )); then
	source "./submodules/obggcc/toolchains/${build_type}.sh"
	cross_compile_flags+="--host=${CROSS_COMPILE_TRIPLET}"
fi

if ! [ -f "${gmp_tarball}" ]; then
	wget --no-verbose 'https://mirrors.kernel.org/gnu/gmp/gmp-6.2.1.tar.xz' --output-document="${gmp_tarball}"
	tar --directory="$(dirname "${gmp_directory}")" --extract --file="${gmp_tarball}"
fi

if ! [ -f "${mpfr_tarball}" ]; then
	wget --no-verbose 'https://mirrors.kernel.org/gnu/mpfr/mpfr-4.2.0.tar.xz' --output-document="${mpfr_tarball}"
	tar --directory="$(dirname "${mpfr_directory}")" --extract --file="${mpfr_tarball}"
fi

if ! [ -f "${mpc_tarball}" ]; then
	wget --no-verbose 'https://mirrors.kernel.org/gnu/mpc/mpc-1.3.1.tar.gz' --output-document="${mpc_tarball}"
	tar --directory="$(dirname "${mpc_directory}")" --extract --file="${mpc_tarball}"
fi

if ! [ -f "${binutils_tarball}" ]; then
	wget --no-verbose 'https://mirrors.kernel.org/gnu/binutils/binutils-2.41.tar.xz' --output-document="${binutils_tarball}"
	tar --directory="$(dirname "${binutils_directory}")" --extract --file="${binutils_tarball}"
fi

if ! [ -f "${gcc_tarball}" ]; then
	wget --no-verbose 'https://mirrors.kernel.org/gnu/gcc/gcc-13.2.0/gcc-13.2.0.tar.xz' --output-document="${gcc_tarball}"
	tar --directory="$(dirname "${gcc_directory}")" --extract --file="${gcc_tarball}"
fi

[ -d "${gmp_directory}/build" ] || mkdir "${gmp_directory}/build"

cd "${gmp_directory}/build"
rm --force --recursive ./*

../configure \
	--prefix="${toolchain_directory}" \
	--enable-shared \
	--enable-static \
	${cross_compile_flags} \
	CFLAGS="${optflags}" \
	CXXFLAGS="${optflags}" \
	LDFLAGS="${linkflags}"

make all --jobs
make install

[ -d "${mpfr_directory}/build" ] || mkdir "${mpfr_directory}/build"

cd "${mpfr_directory}/build"
rm --force --recursive ./*

../configure \
	--prefix="${toolchain_directory}" \
	--with-gmp="${toolchain_directory}" \
	--enable-shared \
	--enable-static \
	${cross_compile_flags} \
	CFLAGS="${optflags}" \
	CXXFLAGS="${optflags}" \
	LDFLAGS="${linkflags}"

make all --jobs
make install

[ -d "${mpc_directory}/build" ] || mkdir "${mpc_directory}/build"

cd "${mpc_directory}/build"
rm --force --recursive ./*

../configure \
	--prefix="${toolchain_directory}" \
	--with-gmp="${toolchain_directory}" \
	--enable-shared \
	--enable-static \
	${cross_compile_flags} \
	CFLAGS="${optflags}" \
	CXXFLAGS="${optflags}" \
	LDFLAGS="${linkflags}"

make all --jobs
make install

declare -ra targets=(
	'x86_64-linux-gnu'
	'x86_64-linux-gnux32'
	'sh4-linux-gnu'
	'm68k-linux-gnu'
	'arm-linux-gnueabi'
	'arm-linux-gnueabihf'
	'aarch64-linux-gnu'
	'i686-linux-gnu'
	'powerpc-linux-gnu'
	'powerpc64-linux-gnu'
	'powerpc64le-linux-gnu'
	's390x-linux-gnu'
	'alpha-linux-gnu'
	'hppa-linux-gnu'
	'riscv64-linux-gnu'
	'sparc64-linux-gnu'
	'mipsisa64r6el-linux-gnuabi64'
	'mipsisa64r6-linux-gnuabi64'
	'mipsisa32r6el-linux-gnu'
	'mipsisa32r6-linux-gnu'
	'mipsel-linux-gnu'
	'mips64el-linux-gnuabi64'
	'mips64-linux-gnuabi64'
	'mips-linux-gnu'
)

for target in "${targets[@]}"; do
	source "${current_source_directory}/${target}.sh"
	
	cd "$(mktemp --directory)"
	
	set +e
	
	for package in "${packages[@]}"; do
		while true; do
			wget --no-verbose "${package}"
			
			if [ "${?}" == '0' ]; then
				break
			fi
		done
	done
	
	set -e
	
	for file in *.deb; do
		ar x "${file}"
		
		if [ -f './data.tar.gz' ]; then
			declare filename='./data.tar.gz'
		else
			declare filename='./data.tar.xz'
		fi
		
		tar --extract --file="${filename}"
		
		rm "${filename}"
	done
	
	[ -d "${toolchain_directory}" ] || mkdir "${toolchain_directory}"
	
	mv "./usr/${target}" "${toolchain_directory}/${triplet}"
	
	cd "${toolchain_directory}/${triplet}/lib"
	
	if ! [ -h './libc.so' ]; then
		if [ -d "../lib64" ]; then
			sed --in-place "s|/usr/${target}/lib64|../lib64|g" './libc.so'
		fi
		sed --in-place "s|/usr/${target}/lib|.|g" './libc.so'
	fi
	
	if ! [ -h './libm.so' ]; then
		if [ -d "../lib64" ]; then
			sed --in-place "s|/usr/${target}/lib64|../lib64|g" './libm.so'
		fi
		sed --in-place "s|/usr/${target}/lib|.|g" './libm.so'
	fi
	
	find . -type l | xargs ls -l | grep '/lib/' | awk '{print "unlink "$9" && ln -s ./$(basename "$11") ./$(basename "$9")"}' | bash
	
	[ -d "${binutils_directory}/build" ] || mkdir "${binutils_directory}/build"
	
	cd "${binutils_directory}/build"
	rm --force --recursive ./*
	
	../configure \
		--target="${triplet}" \
		--prefix="${toolchain_directory}" \
		--enable-gold \
		--enable-ld \
		--enable-lto \
		--disable-gprofng \
		--with-static-standard-libraries \
		--program-prefix="${triplet}-" \
		--with-sysroot="${toolchain_directory}/${triplet}" \
		${cross_compile_flags} \
		CFLAGS="${optflags}" \
		CXXFLAGS="${optflags}" \
		LDFLAGS="${linkflags}"
	
	make all --jobs
	make install
	
	[ -d "${gcc_directory}/build" ] || mkdir "${gcc_directory}/build"
	cd "${gcc_directory}/build"
	
	rm --force --recursive ./*
	
	../configure \
		--target="${triplet}" \
		--prefix="${toolchain_directory}" \
		--with-linker-hash-style='gnu' \
		--with-gmp="${toolchain_directory}" \
		--with-mpc="${toolchain_directory}" \
		--with-mpfr="${toolchain_directory}" \
		--with-static-standard-libraries \
		--with-bugurl='https://github.com/AmanoTeam/Sphynx/issues' \
		--enable-__cxa_atexit \
		--enable-cet='auto' \
		--enable-checking='release' \
		--enable-clocale='gnu' \
		--enable-default-ssp \
		--enable-gnu-indirect-function \
		--enable-gnu-unique-object \
		--enable-libstdcxx-backtrace \
		--enable-link-serialization='1' \
		--enable-linker-build-id \
		--enable-lto \
		--enable-plugin \
		--enable-shared \
		--enable-threads='posix' \
		--enable-libssp \
		--enable-languages='c,c++' \
		--disable-libgomp \
		--disable-bootstrap \
		--disable-multilib \
		--disable-libstdcxx-pch \
		--disable-werror \
		--without-headers \
		--enable-ld \
		--enable-gold \
		--with-gcc-major-version-only \
		--with-pkgversion="Sphynx v0.3-${revision}" \
		--with-sysroot="${toolchain_directory}/${triplet}" \
		--with-native-system-header-dir='/include' \
		--disable-nls \
		--disable-libsanitizer \
		--program-prefix="${triplet}-" \
		${cross_compile_flags} \
		${extra_configure_flags} \
		CFLAGS="${optflags}" \
		CXXFLAGS="${optflags}" \
		LDFLAGS="-Wl,-rpath-link,${OBGGCC_TOOLCHAIN}/${CROSS_COMPILE_TRIPLET}/lib ${linkflags}"
	
	LD_LIBRARY_PATH="${toolchain_directory}/lib" PATH="${PATH}:${toolchain_directory}/bin" make \
		CFLAGS_FOR_TARGET="${optflags} ${linkflags}" \
		CXXFLAGS_FOR_TARGET="${optflags} ${linkflags}" \
		gcc_cv_objdump="${CROSS_COMPILE_TRIPLET}-objdump" \
		all \
		--jobs="$(($(nproc) * 12))"
	make install
	
	cd "${toolchain_directory}/${triplet}/bin"
	
	for name in *; do
		rm "${name}"
		ln -s "../../bin/${triplet}-${name}" "${name}"
	done
	
	rm --recursive "${toolchain_directory}/share"
	
	if [ "${CROSS_COMPILE_TRIPLET}" == "${triplet}" ]; then
		rm "${toolchain_directory}/bin/${triplet}-${triplet}"*
	fi
	
	patchelf --add-rpath '$ORIGIN/../../../../lib' "${toolchain_directory}/libexec/gcc/${triplet}/"*'/cc1'
	patchelf --add-rpath '$ORIGIN/../../../../lib' "${toolchain_directory}/libexec/gcc/${triplet}/"*'/cc1plus'
	patchelf --add-rpath '$ORIGIN/../../../../lib' "${toolchain_directory}/libexec/gcc/${triplet}/"*'/lto1'
done
