#!/usr/bin/env zsh
set -e

ocamlc euler_87_prime_power_triples.ml -o test < /dev/null

./test 50
./test 50000000
./test 287301
./test -923098
./test 0
./test hello
./test