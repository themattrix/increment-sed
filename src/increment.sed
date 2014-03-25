#!/bin/sed -ruf

:list-numbers

    s/^/0123456789 0/
    t increment


:increment

    /_/{
        s/((.)(.).* .*)\2_/\1\3/
        t increment-end

        s/9_/_0/
        t increment
    }

    s/9$/_0/
    t increment

    s/((.)(.).* .*)\2$/\1\3/
    t increment-end


:increment-end

    s/^0123456789 0*//
