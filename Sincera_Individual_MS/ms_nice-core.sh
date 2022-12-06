
port_core=1111
url_core=url
username_core=username	
password_core=passwd
local=192.168.2.3
build_ver=2.0.0.0

#Before unzip 
#unzip sincera-*.zip
#echo -e "\n"


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

        	echo -e "application.yaml in ${new} directory has updated successfully\n"
        	nohup java -jar ${new}-${build_ver}.jar >nohup_core.out 2>&1 &

    fi
done