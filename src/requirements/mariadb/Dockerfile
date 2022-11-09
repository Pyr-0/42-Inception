#=========MariaDB DOCKERFILE===========


# Tell the system where from to build the image, in which OS to build upon
FROM debian:buster

#	Do mind that this port will only be exposed for other docker containers but not for the host
EXPOSE	3306

# install nginx and update the system (debian is limited with its package manager so run apt-get
RUN apt-get update && apt-get install -y \
	mariadb-server mariadb-client && \
	rm -rf /var/lib/apt/lists/*

#	Remove the original config file from mariadb and replace it with your own
RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d


# Copy our config file in the nginx config folder
# COPY ./conf/default /etc/nginx/sites-available
COPY ./conf/default /etc/nginx/sites-available

#Create the self signed SSL certificates and out them in your own files (place them in a new folder)
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out /etc/nginx/ssl/mrojas-e.crt \
	-keyout /etc/nginx/ssl/mrojas-e.key \
	#You could also save them in the ssl folder directly
	# 	-out /etc/ssl/certs/mrojas-e.crt \
	# -keyout /etc/ssl/private/mrojas-e.key \ 
	-subj "/CN=mrojas-e.42.fr/"


#The CMD command will run nginx, but since it runs in the background we need to 
#leave it running in the foreground with the "daemon off;" flag otherwise when the image is
#finished being built nginx will stop.
CMD ["mariadb"]

#-----------------------------