#! /bin/bash
set -e

REPO_CORE=https://github.com/bitcoin/bitcoin.git
COMMIT_CORE=ef70f9b52b851c7997a9f1a0834714e3eebc1fd8

if [ "$root_dir" == '/repo' ]; then
	repos="${REPO_CORE}_${COMMIT_CORE}"
	for repo in ${repos}; do
	  TARGETHOST=armv7a-linux-androideabi
	  docker run -v $PWD:/repo debian:stretch /bin/bash -c "/repo/stretch_deps.sh && /repo/fetchbuild.sh ${repo/_/ } $TARGETHOST 32 /repo" &
	  TARGETHOST=aarch64-linux-android
	  docker run -v $PWD:/repo debian:stretch /bin/bash -c "/repo/fetchbuild.sh ${repo/_/ } $TARGETHOST 64 /repo" &
	  TARGETHOST=x86_64-linux-android
	  docker run -v $PWD:/repo debian:stretch /bin/bash -c "/repo/fetchbuild.sh ${repo/_/ } $TARGETHOST 64 /repo" &
	  TARGETHOST=i686-linux-android
	  docker run -v $PWD:/repo debian:stretch /bin/bash -c "/repo/fetchbuild.sh ${repo/_/ } $TARGETHOST 32 /repo" &
	done


	wait

	echo "DONE"
else
	TARGETHOST=armv7a-linux-androideabi
	./fetchbuild.sh $REPO_CORE $COMMIT_CORE $TARGETHOST 32 $PWD
fi

