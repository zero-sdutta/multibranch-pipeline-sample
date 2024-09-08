#!/bin/bash

b=1
while [ $b != 0 ]
do

  git checkout -b perf-test-$b
  parallel=$b+4
  awk -v p=$parallel 'BEGIN {FS="]"; OFS=""} NR==1 {$1=$1", $p]"} {print $0}' JenkinsFile > JenkinsFile
  git add *
  git commit -m "new branch commit  with increased parallel jobs"
# commit frequency is calculated based on the time interval i.e sleep
  sleep 30

done