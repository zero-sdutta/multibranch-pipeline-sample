#!/bin/bash

git branch | grep "^\s\+perf-test-" | xargs git push origin -d
git branch | grep "^\s\+perf-test-" | xargs git branch -D
