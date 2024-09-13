#!/bin/bash

git branch | grep "perf-*" | xargs git push origin -d
git branch | grep "perf-*" | xargs git branch -D
