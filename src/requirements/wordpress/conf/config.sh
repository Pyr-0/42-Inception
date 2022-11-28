#!/bin/bash
cd /var/www/wordpress

wp core download "--allow-root"

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

# wp theme install chique-photography.1.1.1.zip -activate
wp user create $WP_USER $WP_USER_MAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root

wp config set WP_REDIS_HOST redis --allow-root #I put --allowroot because i am on the root user on my VM
  	wp config set WP_REDIS_PORT 6379 --raw --allow-root
 	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
  	#wp config set WP_REDIS_PASSWORD $REDIS_PASSWORD --allow-root
 	wp config set WP_REDIS_CLIENT phpredis --allow-root
	wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
	wp redis enable --allow-root
# run php-fpm7.3 listening for CGI request 
#Launch PHP FPM in foreground and ignore deamonize from conf file (-F)
php-fpm7.3 -F