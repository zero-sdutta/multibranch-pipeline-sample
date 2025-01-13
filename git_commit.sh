#!/bin/bash

b=1
date
while [ $b != 0 ]
do

  git checkout -b perf-test-$b
  parallel=$(($b+4))
  awk -v p=$parallel 'BEGIN {FS="]"; OFS="";} NR==1 {$1=$1", "p"]"} {print $0}' Jenkinsfile | tee Jenkinsfile
        while true
	do
		if [ -s Jenkinsfile ]
		then
			break
		else
                	git stash
			git stash drop
			git clean -df
                	git checkout perf-test-$(($b-1))
                	git branch -D perf-test-$b
                	git checkout -b perf-test-$b
			git status
			awk -v p=$parallel 'BEGIN {FS="]"; OFS="";} NR==1 {$1=$1", "p"]"} {print $0}' Jenkinsfile | tee Jenkinsfile
			git status
        	fi
	done
  git status
  git add .
  git status
  git commit -m "new branch commit with incremental parallel jobs"
  git push origin perf-test-$b
# commit frequency is calculated based on the time interval i.e. sleep
  sleep 12
  echo $b >> ~/JaaS/iteration-output-5cf-300MLF.txt
  b=$(($b+1))

done    
