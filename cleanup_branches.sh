#!/bin/bash

git branch | grep "perf-*" | xargs git push origin -d
sleep 1
git branch | grep "perf-*" | xargs git branch -D
