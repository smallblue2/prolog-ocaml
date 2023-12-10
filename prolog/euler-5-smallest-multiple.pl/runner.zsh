#!/usr/bin/env zsh

swipl -s euler-5-smallest-multiple.pl -g start -t halt -- 0
swipl -s euler-5-smallest-multiple.pl -g start -t halt -- 10
swipl -s euler-5-smallest-multiple.pl -g start -t halt -- 100
swipl -s euler-5-smallest-multiple.pl -g start -t halt -- 1000
swipl -s euler-5-smallest-multiple.pl -g start -t halt -- 10000
swipl -s euler-5-smallest-multiple.pl -g start -t halt -- -10
swipl -s euler-5-smallest-multiple.pl -g start -t halt -- hello
