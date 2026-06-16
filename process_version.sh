#!/bin/bash
set -exuo pipefail

readonly version="$1"

readonly org='ninja-build'
readonly proj='ninja'
readonly arch='loongarch64'
readonly goarch='loong64'
readonly proj_name="${proj}-${version}"

# 映射目录
readonly workspace="/workspace"
readonly dists="${workspace}/dists"
readonly patches="${workspace}/patches"

readonly build="/build"
readonly source_root="${build}/${proj_name}"
readonly build_root="${build}/${proj_name}"
readonly package_root="${dists}/${proj_name}"

mkdir -p "${build}"

fetch_source_code()
{
    rm -rf "${source_root}"
    git clone --branch "v${version}" --depth=1 "https://github.com/${org}/${proj}" "${source_root}"
}

build(){
    pushd "${build_root}"
        cmake -B build -DCMAKE_BUILD_TYPE=Release
        cmake --build build
        cd build
        zip ../ninja-linux-loongarch64.zip ninja
    popd
}

package(){
    rm -rf "${package_root}"
    mkdir -p "${package_root}"
    pushd "${package_root}"
        cp -a ${build_root}/*.zip ./
    popd

}

main()
{
    fetch_source_code
    build
    package
}

main "$@"
