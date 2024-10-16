#!/bin/bash

git branch | grep "^\s\+perf-test-" | xargs git push origin -d

read -p "Verify remote branches got deleted, proceed with local deletion? [0/1]: " flag

if [ $flag -eq 1 ]
then
	git branch | grep "^\s\+perf-test-" | xargs git branch -D
fi
