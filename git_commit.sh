#!/bin/bash

b=1
date
while [ $b != 0 ]
do

  git checkout -b perf-test-$b
  parallel=$(($b+4))
  awk -v p=$parallel 'BEGIN {FS="]"; OFS="";} NR==1 {$1=$1", "p"]"} {print $0}' JenkinsFile | tee  JenkinsFile
  git add JenkinsFile
  git commit -m "new branch commit with incremental parallel jobs"
  git push --set-upstream origin perf-test-$b
# commit frequency is calculated based on the time interval i.e. sleep
  sleep 5
  echo $b >> ~/JaaS/iteration-output.txt
  b=$(($b+1))

done
