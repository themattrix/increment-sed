#!/usr/bin/env bash

readonly THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function increment_sed() {
    "${THIS_DIR}/../src/increment.sed"
}

function test_increment_from_0_to_10000() {
    diff <(
        for (( i = 0; i < 10000; i++ )); do
            echo "${i}"
        done | increment_sed
    ) <(
        for (( i = 1; i < 10001; i++ )); do
            echo "${i}"
        done
    )
}

test_increment_from_0_to_10000
