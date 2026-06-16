#!/bin/bash

set -ex;

org='ninja-build'
proj='ninja'

version=$1

docker_build() {
    if [[ -z ${version} ]]; then
        version=$(./versions.sh 1)
    fi
    local builder="${org}-${proj}-builder"
    local version=${version#v}
    docker build -t ${builder} .
    docker run --rm -v$(pwd):/workspace -e NINJA_VERSION=${version} ${builder}
    docker rmi ${builder}
}

docker_build
