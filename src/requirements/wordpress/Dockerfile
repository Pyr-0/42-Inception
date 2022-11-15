#========= WORDPRESS  DOCKERFILE ===========

# Tell the system where from to build the image, in which OS to build upon
FROM debian:buster

# Expose the DEPFAULT PORT for wordpress
EXPOSE	9000

# install nginx and update the system (debian is limited with its package manager so run apt-get
RUN apt-get update && apt-get install -y \
	php7.3-fpm \
	php7.3-mysql \
	mariadb-client \
	curl && \
	rm -rf /var/lib/apt/lists/*

# ARG WORDPRESS_DB_HOST=$WORDPRESS_DB_HOST
# ARG WORDPRESS_DB_NAME=$WORDPRESS_DB_NAME
# ARG WORDPRESS_DB_USER=$WORDPRESS_DB_USER
# ARG WORDPRESS_DB_PASSWORD=$WORDPRESS_DB_PASSWORD
# ARG WP_TITLE=$WP_TITLE
# ARG WP_ADMIN_USER=$WP_ADMIN_USER
# ARG WP_ADMIN_PASSWORD=$WP_ADMIN_PASSWORD
# ARG WP_ADMIN_MAIL=$WP_ADMIN_MAIL
# ARG WP_URL=$WP_URL

# RUN apt update && apt -y install \
# 	php-cli \
# 	php-fpm \
# 	php-json \
# 	php-pdo \
# 	php-mysql \
# 	php-zip \
# 	php-gd  \
# 	php-mbstring \
# 	php-curl \
# 	php-xml \
# 	php-pear \
# 	php-bcmath \ 
# 	curl

#	Remove the original config file from wordpress and replace it with your own in the html folder
COPY ./tools/www.conf /etc/php/7.3/fpm/pool.d

#	Add/download/unzip wordpress package in the right folder (quicker than RUN and COPY)
ADD https://wordpress.org/latest.tar.gz /var/www/latest.tar.gz

RUN rm -rf latest.tar.gz
# Install the wordpress command line tool (WP-CLI)
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --output /usr/bin/wp --silent

# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar&& \
# 	chmod +x wp-cli.phar && \
# 	mv wp-cli.phar /usr/local/bin/wp
# Change permissions to the downloaded file and to check use the comand 'wp --info'
RUN chmod +x ./usr/bin/wp

# #Create the folder to enable php start
# RUN mkdir -p /run/php

#we copy the script, give the right to launch it in local on our computer
COPY ./conf/config.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/config.sh
ENTRYPOINT ["/usr/local/bin/config.sh"]

#-----------------------------