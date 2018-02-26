
#!/bin/bash

cd /usr/share/nginx/html 

wget https://wordpress.org/latest.tar.gz

tar -xvf latest.tar.gz 

rm -f latest.tar.gz

cp -R -f /usr/share/nginx/html/wordpress/* /usr/share/nginx/html 

rm -rf wordpress/ 

chown -R nginx:nginx 

chmod -R 755 .d /var/www/html 

