#! /bin/bash
set -e

DOCKERBUILDER=greenaddress/core_builder_for_android

REPO_CORE=https://github.com/bitcoin/bitcoin.git

DOCKERHASH=ab901244b95360cff4f5b48ec6b2cf03084b10decf8b55b6c64c6755e4c1bd57
COMMIT_CORE=ef70f9b52b851c7997a9f1a0834714e3eebc1fd8

REPO_KNOTS=https://github.com/bitcoinknots/bitcoin.git

COMMIT_KNOTS=ab05daa871db7c5772e6477c0bdddaa6f3808afd

repos="${REPO_CORE}_${COMMIT_CORE} ${REPO_KNOTS}_${COMMIT_KNOTS}"
for repo in ${repos}; do
  TARGETHOST=armv7a-linux-androideabi
  docker run -v $PWD:/repo $DOCKERBUILDER@sha256:$DOCKERHASH /bin/bash -c "/repo/fetchbuild.sh ${repo/_/ } $TARGETHOST 32" &
  TARGETHOST=aarch64-linux-android
  docker run -v $PWD:/repo $DOCKERBUILDER@sha256:$DOCKERHASH /bin/bash -c "/repo/fetchbuild.sh ${repo/_/ } $TARGETHOST 64" &
  TARGETHOST=x86_64-linux-android
  docker run -v $PWD:/repo $DOCKERBUILDER@sha256:$DOCKERHASH /bin/bash -c "/repo/fetchbuild.sh ${repo/_/ } $TARGETHOST 64" &
  TARGETHOST=i686-linux-android
  docker run -v $PWD:/repo $DOCKERBUILDER@sha256:$DOCKERHASH /bin/bash -c "/repo/fetchbuild.sh ${repo/_/ } $TARGETHOST 32" &
done


wait

echo "DONE"

