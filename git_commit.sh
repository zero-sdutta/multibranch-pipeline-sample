#!/bin/bash

b=1
date
while [ $b != 0 ]
do

  git checkout -b perf-test-$b
  parallel=$(($b+4))
  awk -v p=$parallel 'BEGIN {FS="]"; OFS="";} NR==1 {$1=$1", "p"]"} {print $0}' JenkinsFile | tee JenkinsFile
        while ! [[ -s JenkinsFile ]]; do
                git stash
		git clean -df
                git checkout perf-test-$(($b-1))
                git branch -D perf-test-$b
                git checkout -b perf-test-$b
                awk -v p=$parallel 'BEGIN {FS="]"; OFS="";} NR==1 {$1=$1", "p"]"} {print $0}' JenkinsFile >JenkinsFile >$(tty)
        done
  git status
  git add .
  git status
  git commit -m "new branch commit with incremental parallel jobs"
  git push origin perf-test-$b
# commit frequency is calculated based on the time interval i.e. sleep
  sleep 6
  echo $b >> ~/JaaS/iteration-output.txt
  b=$(($b+1))

done
date
~    
