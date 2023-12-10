#!/usr/bin/env zsh

swipl -s euler-7-10001-prime.pl -g start -t halt -- 0
swipl -s euler-7-10001-prime.pl -g start -t halt -- 10
swipl -s euler-7-10001-prime.pl -g start -t halt -- 100
swipl -s euler-7-10001-prime.pl -g start -t halt -- 1000
swipl -s euler-7-10001-prime.pl -g start -t halt -- 10001
swipl -s euler-7-10001-prime.pl -g start -t halt -- -10
swipl -s euler-7-10001-prime.pl -g start -t halt -- hello
swipl -s euler-7-10001-prime.pl -g start -t halt --

