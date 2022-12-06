#!/bin/bash
# Before running this script please ensure the below variables are correct

port_core=1111
url_core="jdbc:mysql://192.168.2.3:3306/nice?serverTimezone=UTC"
username_core="nice123"
password_core="nice123"
port_api=1141
port_controller=1151
port_rule=1131
port_db=1121
port_metrics=1191
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
        testing=$(echo $i | grep "sincera-*")
        if [[ $testing == "./sincera-nice-core" ]]
        then
                new=$(echo $testing | awk -F "./" '{print $2}')
                echo "Chaning into ${new} directory"

               cd ${p}/$new/
                port=${port_core} url=${url_core} username=${username_core} password=${password_core} local=${local} yq e 'select (.server.port = env(port)) | (.spring.datasource.username = env(username)) | (.spring.datasource.url= env(url)) | (.spring.datasource.password = env(password)) |(.data[] | select(. == "localhost")) = env(local) | (.api.controller.task.host,.api.controller.metrics.host | select(. == "localhost")) |= env(local)' -i ${p}/${new}/application.yaml

###port=${port_core} url=${url_core} username=${username_core} password=${password_core} yq e 'select (.server.port = env(port)) | (.spring.datasource.username = env(username)) | (.spring.datasource.url= env(url)) | (.spring.datasource.password = env(password))' -i ${p}/${new}/application.yaml
        echo -e "application.yaml in ${new} directory has updated successfully\n"
        nohup java -jar ${new}-${build_ver}.jar >nohup_core.out 2>&1 &

        elif  [[ $testing == "./sincera-nice-db" ]]
        then
            new=$(echo $testing | awk -F "./" '{print $2}')
           echo "Chaning into ${new} directory"
           cd ${p}/$new/
         port=${port_db} local=${local} yq e 'select (.server.port = env(port))|(.data[] | select(. == "localhost")) = env(local) | (.url |= (.metrics) |= sub("localhost", env(local)))' -i ${p}/${new}/application.yaml

###port=${port_db} yq e 'select (.server.port = env(port))' -i ${p}/${new}/application.yaml

           echo "application.yaml in ${new} directory has updated successfully"
            nohup java -jar ${new}-${build_ver}.jar >nohup_db.out 2>&1 &

        elif  [[ $testing == "./sincera-nice-controller" ]]
        then
            new=$(echo $testing | awk -F "./" '{print $2}')
           echo "Changing into ${new} directory"
           cd ${p}/$new/
        port=${port_controller} local=${local} yq e 'select (.server.port = env(port)) | (.url |= (.api[],.db[],.rule,.metrics) |= sub("localhost", env(local))) | (.data[] | select(. == "localhost")) = env(local)' -i ${p}/${new}/application.yaml

###port=${port_controller} yq e 'select (.server.port = env(port))' -i ${p}/${new}/application.yaml

           echo "application.yaml in ${new} directory has updated successfully"
           nohup java -jar nice-task-controller-${build_ver}.jar >nohup_controller.out 2>&1 &


        elif  [[ $testing == "./sincera-nice-rule" ]]
        then
            new=$(echo $testing | awk -F "./" '{print $2}')
           echo "Changing into ${new} directory"
           cd ${p}/$new/

                port=${port_rule} local=${local} yq e 'select (.server.port = env(port))|(.data[] | select(. == "localhost")) = env(local) | (.url |= (.metrics) |= sub("localhost", env(local)))' -i ${p}/${new}/application.yaml

###port=${port_rule} yq e 'select (.server.port = env(port))' -i ${p}/${new}/application.yaml

           echo "application.yaml in ${new} directory has updated successfully"
           nohup java -jar ${new}-${build_ver}.jar >nohup_rule.out 2>&1 &


        elif  [[ $testing == "./sincera-nice-api" ]]
        then
            new=$(echo $testing | awk -F "./" '{print $2}')
           echo "Changing into ${new} directory"
           cd ${p}/$new/

        port=${port_api} local=${local} yq e 'select (.server.port = env(port))|(.data[] | select(. == "localhost")) = env(local) | (.url |= (.metrics) |= sub("localhost", env(local)))' -i ${p}/${new}/application.yaml


###port=${port_api} yq e 'select (.server.port = env(port))' -i ${p}/${new}/application.yaml

           echo "application.yaml in ${new} directory has updated successfully"
           nohup java -jar ${new}-${build_ver}.jar >nohup_api.out 2>&1 &

        elif  [[ $testing == "./sincera-nice-metrics" ]]
        then
            new=$(echo $testing | awk -F "./" '{print $2}')
           echo "Changing into ${new} directory"
           cd ${p}/$new/



           port=${port_metrics} local=${local} yq e 'select (.server.port = env(port)) | (.data[] | select(. == "localhost")) = env(local)' -i ${p}/${new}/application.yaml


                echo "application.yaml in ${new} directory has updated successfully"
                nohup java -jar nice-metrics-aggregate-${build_ver}.jar >nohup_metrics.out 2>&1 &


    fi


done
