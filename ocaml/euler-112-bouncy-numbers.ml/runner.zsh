#!/usr/bin/env zsh
set -e

ocamlc euler_112_bouncy_numbers.ml -o test < /dev/null

./test 99
./test 90
./test 75
./test 100
./test 0
./test -23
./test hello
./test