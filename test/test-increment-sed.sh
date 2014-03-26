#!/usr/bin/env bash

#
# Tests
#

function test_carry_once() {
    diff_output <(
        increment_sed <<< "9+."
    ) <(
        echo "10"
    )
}

function test_carry_twice() {
    diff_output <(
        increment_sed <<< "99+."
    ) <(
        echo "100"
    )
}

function test_carry_three_times() {
    diff_output <(
        increment_sed <<< "999+."
    ) <(
        echo "1000"
    )
}

function test_add_from_0_to_111() {
    local limit=111

    diff_output <(
        for ((i = 0; i <= "${limit}"; i++)); do
            {
                printf "0+%${i}s\n" ''
                printf "1+%${i}s\n" ''
                printf "2+%${i}s\n" ''
                printf "3+%${i}s\n" ''
            } | sed 's/ /./g'
        done | increment_sed
    ) <(
        for ((i = 0; i <= "${limit}"; i++)); do
            echo "${i}"
            echo "$((i + 1))"
            echo "$((i + 2))"
            echo "$((i + 3))"
        done
    )
}

function test_increment_from_0_to_111() {
    local limit=111

    diff_output <(
        for ((i = 0; i <= "${limit}"; i++)); do
            echo "${i}+"
            echo "${i}+."
            echo "${i}+.."
            echo "${i}+..."
        done | increment_sed
    ) <(
        for ((i = 0; i <= "${limit}"; i++)); do
            echo "${i}"
            echo "$((i + 1))"
            echo "$((i + 2))"
            echo "$((i + 3))"
        done
    )
}


#
# Test helpers
#

readonly THIS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function increment_sed() {
    "${THIS_DIR}/../src/increment.sed"
}

function diff_output() {
    diff -y --width=12 --suppress-common-lines "$@"
}

function run() {
    test_fn="$1"

    output=$("${test_fn}" 2>&1)
    status=$?

    ((test_count++))

    if [ ${status} -eq 0 ]
    then
        echo "[pass] ${test_fn}"
    else
        ((fail_count++))

        echo "[FAIL] ${test_fn}:"
        sed 's/^/    /' <<< "${output}"
        echo
    fi
}

function test_summary() {
    echo
    if [ ${fail_count} -eq 0 ]
    then
        echo ">>> success (${test_count} tests)"
    else
        echo ">>> FAILURE (${fail_count}/${test_count} tests failed)"
        exit 1
    fi
}


#
# Test runner
#

test_count=0
fail_count=0

run test_carry_once
run test_carry_twice
run test_carry_three_times
run test_add_from_0_to_111
run test_increment_from_0_to_111

test_summary
