FROM wyveo/nginx-php-fpm

MAINTAINER aureiondongelo@gmail.com

ADD wordpress.sh /wordpress.sh

RUN chmod 700 /wordpress.sh

EXPOSE 80

CMD ["/wordpress.sh"]


