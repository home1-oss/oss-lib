#!/usr/bin/env bash

### OSS CI CONTEXT VARIABLES BEGIN
if [ -n "${CI_BUILD_REF_NAME}" ] && ([ "${CI_BUILD_REF_NAME}" == "master" ] || [ "${CI_BUILD_REF_NAME}" == "develop" ]); then BUILD_SCRIPT_REF="${CI_BUILD_REF_NAME}"; else BUILD_SCRIPT_REF="develop"; fi
if [ -z "${GIT_SERVICE}" ]; then
    if [ -n "${CI_PROJECT_URL}" ]; then INFRASTRUCTURE="internal"; GIT_SERVICE=$(echo "${CI_PROJECT_URL}" | sed 's,/*[^/]\+/*$,,' | sed 's,/*[^/]\+/*$,,'); else INFRASTRUCTURE="local"; GIT_SERVICE="${LOCAL_GIT_SERVICE}"; fi
fi
if [ -z "${GIT_REPO_OWNER}" ]; then
    if [ -n "${TRAVIS_REPO_SLUG}" ]; then
        GIT_REPO_OWNER=$(echo ${TRAVIS_REPO_SLUG} | awk -F/ '{print $1}');
    else
        if [ -z "${INTERNAL_GIT_SERVICE_USER}" ]; then GIT_REPO_OWNER="infra"; else GIT_REPO_OWNER="${INTERNAL_GIT_SERVICE_USER}"; fi
    fi
fi
### OSS CI CONTEXT VARIABLES END

export BUILD_PUBLISH_DEPLOY_SEGREGATION="true"
export BUILD_SITE="true"
export BUILD_SITE_PATH_PREFIX="oss"
export BUILD_TEST_FAILURE_IGNORE="false"
export BUILD_TEST_SKIP="false"

export GRADLE_INIT_SCRIPT="${GIT_SERVICE}/${GIT_REPO_OWNER}/oss-build/raw/${BUILD_SCRIPT_REF}/src/main/gradle/init-oss-lib.gradle"

### OSS CI CALL REMOTE CI SCRIPT BEGIN
echo "eval \$(curl -s -L ${GIT_SERVICE}/${GIT_REPO_OWNER}/oss-build/raw/${BUILD_SCRIPT_REF}/src/main/ci-script/ci.sh)"
eval "$(curl -s -L ${GIT_SERVICE}/${GIT_REPO_OWNER}/oss-build/raw/${BUILD_SCRIPT_REF}/src/main/ci-script/ci.sh)"
### OSS CI CALL REMOTE CI SCRIPT END

if [ "${GIT_REPO_OWNER}" != "home1-oss" ] && [ "${1}" != "test_and_build" ]; then
    echo "skip deploy/publish on forked repo"
else
    $@
fi

# after build default version, build other versions
if [ "${GIT_REPO_OWNER}" != "home1-oss" ] && [ "${1}" != "test_and_build" ]; then
    echo "skip deploy/publish on forked repo"
else
    VERSIONS=( "1.4.1.RELEASE" "1.4.2.RELEASE" )
    export ORIGINAL_GRADLE_PROPERTIES="${GRADLE_PROPERTIES}"
    for version in "${VERSIONS[@]}"; do
        export GRADLE_PROPERTIES="${ORIGINAL_GRADLE_PROPERTIES} -PspringBootVersion=${version}"
        gradle_$@
    done
fi