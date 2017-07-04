#!/usr/bin/env bash

if [ -f codesigning.asc.enc ] && [ "${TRAVIS_PULL_REQUEST}" == 'false' ]; then
    openssl aes-256-cbc -K $encrypted_21e7221bbe67_key -iv $encrypted_21e7221bbe67_iv -in codesigning.asc.enc -out codesigning.asc -d
    gpg --fast-import codesigning.asc
    if [ -n "${GPG_KEYID}" ]; then gpg --keyring secring.gpg --export-secret-key ${GPG_KEYID} > secring.gpg; fi
fi

export BUILD_SITE_PATH_PREFIX="oss"
export GRADLE_INIT_SCRIPT="https://github.com/home1-oss/oss-build/raw/master/src/main/gradle/init-oss-lib.gradle"
#export GRADLE_INIT_SCRIPT="http://gitlab.local:10080/home1-oss/oss-build/raw/develop/src/main/gradle/init-oss-lib.gradle"




### OSS CI CALL REMOTE CI SCRIPT BEGIN
if [ -z "${LIB_CI_SCRIPT}" ]; then LIB_CI_SCRIPT="https://github.com/home1-oss/oss-build/raw/master/src/main/ci-script/lib_ci.sh"; fi
#if [ -z "${LIB_CI_SCRIPT}" ]; then LIB_CI_SCRIPT="http://gitlab.local:10080/home1-oss/oss-build/raw/master/src/main/ci-script/lib_ci.sh"; fi
echo "eval \$(curl -s -L ${LIB_CI_SCRIPT})"
eval "$(curl -s -L ${LIB_CI_SCRIPT})"
#source src/main/ci-script/lib_ci.sh
### OSS CI CALL REMOTE CI SCRIPT END

export ORIGINAL_GRADLE_PROPERTIES="${GRADLE_PROPERTIES}"
SPRING_BOOT_VERSIONS=( "1.4.2.RELEASE" )

for command in ${COMMANDS_WILL_PERFORM[@]}; do
    if [ "${command}" != "clean" ]; then
        NEW_ARRAY+=("${element}")
    fi
done
COMMANDS_WILL_PERFORM=("${NEW_ARRAY[@]}")
unset NEW_ARRAY

echo ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>> execute '${COMMANDS_WILL_PERFORM[@]}' on spring-boot '${SPRING_BOOT_VERSIONS[@]}' >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
for spring_boot_version in "${SPRING_BOOT_VERSIONS[@]}"; do
    export GRADLE_PROPERTIES="${ORIGINAL_GRADLE_PROPERTIES} -PspringBootVersion=${spring_boot_version}"
    for command in ${COMMANDS_WILL_PERFORM[@]}; do
        echo ">>>>>>>>>>>>>>>>>>>> execute 'gradle_${command}' on spring-boot '${spring_boot_version}' >>>>>>>>>>>>>>>>>>>>"
        gradle_${command}
        echo "<<<<<<<<<<<<<<<<<<<< done 'gradle_${command}' on spring-boot '${spring_boot_version}' <<<<<<<<<<<<<<<<<<<<"
    done
done
echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< done '${COMMANDS_WILL_PERFORM[@]}' on spring-boot '${SPRING_BOOT_VERSIONS[@]}' <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
