#!/bin/bash
# Before running this script please ensure the below variables are correct

port_db=1121
build_ver=2.0.0.0-SNAPSHOT
local=192.168.2.3


#Make sure you are in  directory  proper zip file

unzip sincera-*.zip
echo -e "\n"
cd sincera-nice-${build_ver}

p=$(pwd)
sincera=$(find ./ -name 'sincera-*')

for i in $sincera
do
        
   if 
        [[ $testing == "./sincera-nice-db" ]]
    
            new=$(echo $testing | awk -F "./" '{print $2}')
           echo "Chaning into ${new} directory"
           cd ${p}/$new/
         port=${port_db} local=${local} yq e 'select (.server.port = env(port))|(.data[] | select(. == "localhost")) = env(local) | (.url |= (.metrics) |= sub("localhost", env(local)))' -i ${p}/${new}/application.yaml

           echo "application.yaml in ${new} directory has updated successfully"
            nohup java -jar ${new}-${build_ver}.jar >nohup_db.out 2>&1 &

    fi

done
