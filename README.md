# centos-nginx-wordpress
This repository contain a Dockerfile to build a data container image that mount DocumentRoot for nginx, and install **wordpress** in the directory and also mount it on the host machine, to create a niginx container I will use this image **minhdanh/nginx-php7-fpm** (it’s an image of nginx with php installed).
## Base Docker Image
* centos
### Use of this image
You can use this repository to create data-container witch will map on directory /usr/share/nginx/html and for nginx server /var/lib/mysql for mariadb.

### Prerequisites 

#Creation of a new network called nginxarxa.

**$ docker network create nginxarxa**
 
First we need create a network that we will use while creating containers

**$ docker create --name datacontainer --network nginxarxa ndongelo/centos-nginx-wordpress**

Then we create a container with this image.

Here I am using **orboan/dcsss-mariadb** image to create a container based on mariadb here we create a     
database for our **wordpress**.

## Docker run example:
With **--name** you can give a name to you container at container creation time.

With **MYSQL_ROOT_PASSWORD** enviroment variable you can set the mariadb root password at container creation time.

With **MYSQL_DATABASE1**, **MYSQL_USER1**, **MYSQL_PASSWORD1** you can create a mysql db, user with all privileges upon this db, and its password, at container creation time.

You can also create up to 10 triplets (db, user, password) using MYSQL_DATABASEn, MYSQL_USERn, MYSQL_PASSWORDn environment variables, with n=1..10

**3306:3306** maps the mariadb server 
## docker run -itd -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE1=wordb -e MYSQL_USER1=aurel -e MYSQL_PASSWORD1=aurel --volumes-from datacontainer --network nginxarxa  --name db orboan/dcsss-mariadb

We also use **-d** option for container to run in background and print container ID.

**$ docker run -itd -p 8080:80 --name nginx --network nginxarxa  ndongelo/centos-nginx-php **

With **--name** you can give a name to you container at container creation time. 

With **-p 8080:80** Mapping the port **8080** of the host machine to port **80** of the container, it’s the port that nginx server use by default, and mapping volumes from datacontainer with **--volumes-from datacontainer**.

With this command we create on nginx based container with image **wyveo/nginx-php-fpm** (In this image nginx is installed with php and it's configured in way where **nginx work directory(DocumentRoot) would be /usr/share/nginx/html
** )

**Then you can http://host-ip:80 in your browser** and while you setup your **wordpress** you should take in considration that in **Database Host** field you have to insert your localhost or host-ip with port **3306** and also you will use the same **user** and **password** that you created while creating **mariadb container**.



## script ( exercici3.sh ) 
You can run the following script to create a network for the containers and a create datacontainer with this image (ndongelo/centos-nginx-wordpress) which maps the nginx directory /usr/share/nginx/html/ and mariadb directory /var/lib/mysql and also runs nginx and mariadb containers.

#Creating a container named datacontainer with the image centos which is mapping volumes /data:/usr/share/nginx/html/ for nginx and /data:/var/lib/mysql (database for wordpress) for mariadb.
docker create --name datacontainer -v /data:/usr/share/nginx/html/ -v /data:/var/lib/mysql centos

#Creation of a new network called wpnet.
**docker network create nginxarxa**

#Create a mariadb-based container named db with image orboan/dcsss-mariadb using volumes of the datacontainer

**docker run -itd -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE1=wordb -e MYSQL_USER1=aurel -e MYSQL_PASSWORD1=aurel --volumes-from datacontainer --network nginxarxa  --name db orboan/dcsss-mariadb**

#Create a container based on nginx called nginx with image minhdanh/nginx-php7-fpm using datacontainer volumes.
**docker run -itd -p 8080:80 --name nginx --network nginxarxa  ndongelo/centos-nginx-php**

### Used images in the process
**orboan/dcsss-mariadb**
**minhdanh/nginx-php7-fpm**
**ndongelo/centos-nginx-wordpress**

## Acknowledgments
The code was inspired by **orboan/dcsss-httpd-wordpress** image.

## Authors
**Author:** NdongElo

