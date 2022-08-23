FROM debian:buster
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	vim \
	sysvinit-utils \
	wget \
	nginx \
	mariadb-server \
	php-cgi \
	php-common \
	php-fpm \
	php-pear \
	php-mbstring \
	php-zip \
	php-net-socket \
	php-gd \
	php-xml-util \
	php-gettext \
	php-mysql \
	php-bcmath
	
# NGINX will need a folder where it will search for everything related to our website
# We can use the "html" folder that already exists in var/www directory,
# but it's a good practice to have a separate folder for every website in case we create more than 1
RUN mkdir /var/www/localhost

# COPY copies files from the given directory on our computer to given directory inside our container.
# If a file already exists in the specified directory, it will overwrite it
# We place it inside /etc/nginx/sites-available as required per NGINX documentation
COPY srcs/localhost /etc/nginx/sites-available

# We also need to create a link between the 2 following folder to "enable" our website
RUN ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled

# For the next steps, we will be working inside /var/www/localhost directory
# To avoid writing /var/www/localhost before every command, we can change current working directory
# WORKDIR command in dockerfile changes the directory where next commands will be executed
WORKDIR /var/www/localhost/

RUN openssl req -x509 -nodes -days 30 -subj "/C=BE/ST=Belgium/L=Brussels/O=42 Network/OU=s19/CN=ysoroko" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

COPY ./srcs/start.sh ./

# Download phpMyAdmin by using "wget" which we installed in step 2
# At the time you do this you might need to download a different version from 5.1.0
# Try to always use the latest version
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-english.tar.gz

# Extract the downloaded compressed files and remove the ".tar" file we no longer need
RUN tar -xf phpMyAdmin-5.1.0-english.tar.gz && rm -rf phpMyAdmin-5.1.0-english.tar.gz

# Rename the downloaded folder by "phpmyadmin"
RUN mv phpMyAdmin-5.1.0-english phpmyadmin

# Copy the "config.inc.php" file we created to the same "phpmyadmin" folder
COPY ./srcs/config.inc.php phpmyadmin

RUN wget https://wordpress.org/latest.tar.gz

# Extract it and remove the .tar file
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz 

# Copy our configuration file inside the container
COPY ./srcs/wp-config.php /var/www/localhost/wordpress

# Change ownership and allow access to all the files
# This is required for phpMyAdmin to have acces to all the data, otherwise it will display an error
RUN chown -R www-data:www-data *
RUN chmod -R 755 /var/www/*

CMD bash
