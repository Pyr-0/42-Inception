#!/bin/bash
cd /var/www/wordpress
wp core config	"--dbhost=$WORDPRESS_DB_HOST" \
				"--dbname=$WORDPRESS_DB_NAME" \
				"--dbuser=$WORDPRESS_DB_USER" \
				"--dbpass=$WORDPRESS_DB_PASSWORD" \
				"--allow-root"

wp core install "--title=$WP_TITLE" \
				"--admin_user=$WP_ADMIN_USER" \
				"--admin_password=$WP_ADMIN_PASSWORD" \
				"--admin_email=$WP_ADMIN_MAIL" \
				"--url=$WP_URL" \
				"--allow-root"

wp user create $WP_USER $WP_USER_MAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root

# run php-fpm7.3 listening for CGI request 
#Launch PHP FPM in foreground and ignore deamonize from conf file (-F)
php-fpm7.3 -F