#!/usr/bin/env zsh
set -e

ocamlc euler_179_consecutive_positive_divisors.ml -o test < /dev/null

./test 0
./test 10
./test 100
./test 1000
./test 10000
./test 100000
./test 1000000
./test 1000000000
./test -10
./test hello
./test