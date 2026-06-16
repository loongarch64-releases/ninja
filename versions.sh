#!/usr/bin/bash

org='ninja-build'
proj='ninja'
number=${1:-10}

versions(){
    curl -sL "https://api.github.com/repos/${org}/${proj}/releases" | jq -r ".[].tag_name" | \
        sort -rV | \
        head -n ${number} | \
        sed 's:v::g'
}

versions
