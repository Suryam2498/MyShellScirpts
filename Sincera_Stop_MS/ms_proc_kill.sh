#!/bin/bash

#ps -ef | grep 'java' | awk '{print $2,$8,$NF}'  > test1

ps -ef | grep -E "sincera-nice|nice-task|nice-metrics" | awk '{print $2,$NF}' > test1

while read process name
do
  ms_jar=$(echo $name | awk -F '.' '{print $NF}')

  if [[ "${ms_jar}" == "jar" ]]
  then
      echo "$name  PID: $process"
      sudo kill -9 $process
  fi

done < test1


echo " Above proceses are killed"
