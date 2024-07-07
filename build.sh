#!/usr/bin/env bash

set -eu -o pipefail && cd "$(dirname "$0")" >/dev/null 2>&1

# cleanup if any
[[ ${1:-} == cc ]] && rm -rf -- build install && exit
[[ ${1:-} == c ]] && rm -rf -- build install

# build
cmake -S . -B build -G Ninja
cmake --build build
cmake --install build --prefix install

# run
build/test.py
install/test.py
