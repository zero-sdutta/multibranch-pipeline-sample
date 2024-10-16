#!/bin/bash

git branch | grep "^perf-" | xargs git push origin -d
read -p "verify remote branches are cleared to proceed[Y] clearing local otherwise abort[N]: " flag

if [ "$flag" -eq "Y"]; then 
	git branch | grep "^perf-" | xargs git branch -D
fi
