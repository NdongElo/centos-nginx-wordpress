
docker create --name datacontainer -v /data:/usr/share/nginx/html/ -v /data:/var/lib/mysql centos

docker network create nginxarxa

echo "Contenedor db"

docker run -itd -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE1=wordb -e MYSQL_USER1=aurel -e MYSQL_PASSWORD1=aurel --volumes-from datacontainer --network nginxarxa  --name db orboan/dcsss-mariadb

docker run -itd -p 8080:80 --name nginx --network nginxarxa  ndongelo/centos-nginx-php

