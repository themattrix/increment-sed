#!/bin/sed -ruf

:increment

    s/(^|0)_/1/
    t increment-end
    s/1_/2/
    t increment-end
    s/2_/3/
    t increment-end
    s/3_/4/
    t increment-end
    s/4_/5/
    t increment-end
    s/5_/6/
    t increment-end
    s/6_/7/
    t increment-end
    s/7_/8/
    t increment-end
    s/8_/9/
    t increment-end
    s/9_/_0/
    t increment

    s/(^|0)$/1/
    t increment-end
    s/1$/2/
    t increment-end
    s/2$/3/
    t increment-end
    s/3$/4/
    t increment-end
    s/4$/5/
    t increment-end
    s/5$/6/
    t increment-end
    s/6$/7/
    t increment-end
    s/7$/8/
    t increment-end
    s/8$/9/
    t increment-end
    s/9$/_0/
    t increment

:increment-end

