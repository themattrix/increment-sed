#!/usr/bin/env bash

readonly THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function increment_sed() {
    "${THIS_DIR}/../src/increment.sed"
}

function test_increment_from_0_to_100000() {
    diff <(
        for (( i = 0; i < 100000; i++ )); do
            echo "${i}"
        done | increment_sed
    ) <(
        for (( i = 1; i < 100001; i++ )); do
            echo "${i}"
        done
    )
}

test_increment_from_0_to_100000
