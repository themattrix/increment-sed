#!/usr/bin/env bash

readonly THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function increment_sed() {
    "${THIS_DIR}/../src/increment.sed"
}

function test_increment_from_0_to_10000() {
    diff <(
        for (( i = 0; i < 10000; i++ )); do
            echo "${i}+."
            echo "${i}+.."
            echo "${i}+..."
        done | increment_sed
    ) <(
        for (( i = 0; i < 10000; i++ )); do
            echo "$((i + 1))"
            echo "$((i + 2))"
            echo "$((i + 3))"
        done
    )
}

test_increment_from_0_to_10000
