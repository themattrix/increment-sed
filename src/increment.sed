#!/bin/sed -ruf
#
# Script to add two numbers together.
#
# Input expectation: "<base-10 number>+<unary number>"
# 
# Examples:
#
#     Add one:
#         "99+."  => "100"
#
#     Add two:
#         "99+.." => "101"
#
#     Add five:
#         "7+....." => "12"
#

:list-numbers

    s/^/0123456789 0/
    t add


:add

    /\+$/b increment-end
    s/.$//
    t increment


:increment

    /_/{
        s/((.)(.).* .*)\2_/\1\3/
        t add

        s/9_/_0/
        t increment
    }

    s/9\+/_0+/
    t increment

    s/((.)(.).* .*)\2\+/\1\3+/
    t add


:increment-end

    s/^0123456789 0*//
    s/\+$//
