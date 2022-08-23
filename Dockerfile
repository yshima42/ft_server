FROM debian:buster

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
			sysvinit-utils \
			wget \
			nginx \
			mariadb-server \
			php-cgi php-common php-fpm php-pear php-mbstring \
			php-zip php-net-socket php-gd php-xml-util php-gettext php-mysql \
			php-bcmath \
			vim

RUN mkdir /var/www/localhost

COPY srcs/localhost /etc/nginx/sites-available

RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled

WORKDIR /var/www/localhost/

RUN openssl req -x509 -nodes -days 30 -subj "/C=BE/ST=Belgium/L=Brussels/O=42 Network/OU=s19/CN=ysoroko" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;


