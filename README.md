increment.sed
=============

Sed script to add two numbers together. The first number must be base-10, and the second must be base-1 (any characters).

For example:

    $ echo "7+....." | ./src/increment.sed
    12

    $ echo "99+." | ./src/increment.sed
    100
