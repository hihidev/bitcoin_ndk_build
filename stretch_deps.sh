#!/bin/bash
set -e
export NDK_VERSION=android-ndk-r19
export NDK_FILENAME=${NDK_VERSION}-linux-x86_64.zip

sha256_file=c0a2425206191252197b97ea5fcc7eab9f693a576e69ef4773a9ed1690feed53

apt-get -yqq update &> /dev/null
apt-get -yqq upgrade &> /dev/null
apt-get -yqq install python curl build-essential libtool autotools-dev automake pkg-config bsdmainutils unzip git &> /dev/null

mkdir -p /opt

cd /opt && curl -sSO https://dl.google.com/android/repository/${NDK_FILENAME} &> /dev/null
echo "${sha256_file}  ${NDK_FILENAME}" | shasum -a 256 --check
unzip -qq ${NDK_FILENAME} &> /dev/null
rm ${NDK_FILENAME}

if [ -f /.dockerenv ]; then
    apt-get -yqq --purge autoremove unzip
    apt-get -yqq clean
    rm -rf /var/lib/apt/lists/* /var/cache/* /tmp/* /usr/share/locale/* /usr/share/man /usr/share/doc /lib/xtables/libip6*
fi
