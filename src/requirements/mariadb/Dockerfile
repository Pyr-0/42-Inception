#=========MariaDB DOCKERFILE===========

# Tell the system where from to build the image, in which OS to build upon
FROM debian:buster

#	Do mind that this port will only be exposed for other docker containers but not for the host
EXPOSE	3306


#	DEPENDANCIES
RUN apt-get update && apt-get install -y \
	mariadb-server mariadb-client && \
	rm -rf /var/lib/apt/lists/*

#	Remove the original config file from mariadb and replace it with your own
RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d
RUN mysql_install_db 

# Set the ARG values where the database will take reference from
ARG DB_NAME=${DB_DATABASE}
ARG DB_USER=${DB_USER}
ARG DB_PASSWORD=${DB_PASSWORD}
ARG DB_ROOT_PASSWORD=${DB_ROOT_PASSWORD}

# Copy the script to create your user in your desired folder where you will run it from
COPY ./tools/create_user.sh /

#RUN chmod +x ./create_user.sh  to give permission
RUN bash ./create_user.sh
RUN service mysql stop


#The CMD command will run nginx, but since it runs in the background we need to 
#leave it running in the foreground with the "daemon off;" flag otherwise when the image is
#finished being built nginx will stop.
CMD ["mysqld_safe"]

#-----------------------------