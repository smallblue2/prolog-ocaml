#!/usr/bin/env zsh
set -e

ocamlc euler_20_factorial_digit_sum.ml -o test < /dev/null

./test 100
./test 50
./test 68
./test 1
./test 0
./test -23
./test hello
./test