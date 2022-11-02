<br><h2 align="center"><u>42 INCEPTION - INSTRUCTIVE GUIDE</u></h1>
<p align="center">
  <a href="" rel="noopener">
 <img width=100px height=100px src="https://i.pinimg.com/originals/70/b2/f1/70b2f130bdb8d52c11eb69b83beef20e.gif" alt="Project logo"></a>
</p>


<div align="center">

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)

[![License: WTFPL](https://img.shields.io/badge/License-WTFPL-brightgreen.svg)](http://www.wtfpl.net/about/)

[![License: CC0-1.0](https://licensebuttons.net/l/zero/1.0/80x15.png)](http://creativecommons.org/publicdomain/zero/1.0/)
</div>

---
## 📝 Table of Contents

- [About](#about)
- [Before you start: Suggestions](#suggestions)
- [Getting Started](#getting_started)
- [Straight to the point](#to_the_point)
- [Nginx](#nginx)
- [Resources](#resources)

## <u>📓 About <a name = "about"></a></u>

Inception is a project about Docker containers, this will help expand knowledge about system administration and some Web development skills as well.\
This project can also be understood under the name of ```LEMP Stack Deployment``` <sup> [learn more](#lemp)</sup>  \
which simply stands for Linux, NGINX (pronounced Engine X), MySQL, and PHP-FPM.

## <u>🤖 Before you start: Suggestions <a name = "suggestions"></a></u>

This project carries a lot of diverse topics, and with them <u>A LOT</u>  of documentation, for that reason I created this guide, to have the [Resources](#resources) necessary for you to get some information about each topic and hopefully save some hours and avoid falling down the rabbit hole of material that one can find online. \
For the order of the project I want to suggest some points that helped me to not get lost, learn comfortably and move forward quicker.\
\
(this are tips that help me but are not necessary to follow, so feel free to find what its best for you, ___this is not a copy-paste guide so you will still have to figure some things out__ ✌🏼) 

1. <u>Use a SSH connection</u> between your VM and your work station<sup> [learn how](#ssh)</sup>\
(___specially if you are working at 42 campus with limited ram on your VM___), For this my choice was to use the extension  for __Visual Studio code__ called `Remote - SSH`. 
 <br>[  [Download it here](#remotessh)</sup> ]

<p align="center"> <img width=650 src= "./assets/ssh-readme.gif"> </p>

This will make it  easier to work on the project if you like, for example, opening multiple files while also navigating through the folder structure of your machine.<br> 


2. <u>_Do ONE container at a time._</u> It will be easier to handle errors and to give order to the topics you will learn, the logic I followed was:
	
	- [Nginx](#nginx)\
	Learn first how to launch a docker image && to execute this image without using docker-compose\
    Learn How to display an html page on http://localhost:80"\
    Learn how to display an html page with SSL on http://localhost:443"

	- [WordPress+PHP](#wordpress)\
	You can begin from here the docker-compose file, you don't need it before
	- [MariaDB](#mariadb)
	- [Bonus](#bonus)

3. ___Check how other people solved this exercise___, there are many and very different ways to approach the tasks of the project, it all comes down to how each person learned to write in `bash` and on which OS they run their VM on, this will determine which commands differ from their syntax even if they do the same. (sounds basic, but many people with few experience in deep UNIX language might struggle with how this). Reading other peoples solution gives a relationship with what does and doesn't `THIS PROJECT` really needs and what is standard in the use of the technologies, packages and tools used and learned here. \
\
In short, if you don't know how to do something, see what others do, try to understand it and then write your approach.

4. ___Speedrun the project___ 🤪 (AKA the super alternative learning method)\
Weird suggestion I know, but it has proven me to work to a certain extent with other projects. In this case I suggest you to do this <u>ONLY</u> if you feel like understanding and reinforcing on what you just did. \
No need to write all files from the beginning, I mean, you already did right?, so its a matter of straight checking boxes and using the material you already created

## 🎬 <u>Getting Started <a name = "getting_started"></a></u>

***<h3>Setting up a Virtual Machine</h3>***

The first step for this project is obviously to get your hands on a ```virtual machine``` with any Linux distribution. In this machine you will need to install ``` Docker && Docker-compose``` and setup the according ```sudo permissions``` necessary for your user to work. 
1. _<h3><p align="left" >Install and configure your ssh in your VM</h3>_

```shell
>	sudo apt-get update			# update the system
>	sudo apt-get upgrade			# upgrade to current version
>	sudo apt-get install openssh-server	# install ssh service
>	sudo systemctl enable ssh		# enable ssh service
>	sudo systemctl status ssh		# check if its running
>	sudo apt-get install -y ufw		# install firewall
>	sudo ufw allow ssh			# install allow ssh connection via port 22/tcp
>	sudo ufw enable				# enable firewall
>	sudo ufw status				# check status
>	ssh username@IP_address			# connect to your VM ip address via ssh
```
</p>

2. _<h3><p align="left" >Install Docker and Docker-compose VM</h3>_

```shell
>	sudo apt-get install docker			# install Docker
>	sudo apt-get install -y docker-compose		# install Docker-compose
```
</p>

3. _<h3><p align="left" >Configure user groups and permissions VM</h3>_
```shell
> sudo adduser user_name				# If needed add a new user
> sudo usermod -aG sudo user_name			# Add user to sudo group
> sudo usermod -aG docker user_name			# add user to docker group
````

***<h3>Getting familiar with Docker</h3>***

This project is mainly about learning to use Docker so its good to start getting familiar with what it is and the common commands to use it. \
Docker is a tool designed to make it easier to create, deploy, and run applications by using containers. Containers allow a developer to package up an application with all of the parts it needs, such as libraries and other dependencies, and ship it all out as one package.<sup>[Learn more](#learnmore2) </sup> 

<br>

In order to build our containers, each will need a set of instructions that can install the corresponding dependencies for each Service to run and this instructions are writen in a file called `Dockerfile`

**DOCKERFILE\'S  MAIN SYNTAX**:<br>
```Docker
FROM		# Instruction used to specify the valid docker image name.
		# So specified Docker Image will be downloaded from the
		# docker hub registry if it is not exists locally.

RUN		# This runs a Linux command. Used to install packages into
		# container, create folders, etc.

COPY		# Instruction is used to copy files, directories and remote URL files
		# to the destination within the filesystem of the Docker Images. 

ADD			#This command works like a mix of RUN and COPY.
		# A valid use case for ADD is when you want to extract a local tar file
		# into a specific directory in your Docker image.

EXPOSE		# Instruction is used to inform about the network ports that the container 
		# listens on runtime. Docker uses this information to interconnect containers
		# using links and to set up port redirection on docker host system.

CMD		# Allows you to set a default command which will be executed only when
		# you run a container without specifying a command.
```
It will be important that you start getting familiar with Docker and with the syntax of Docker Files and of Docker-compose. this two files are basically the ```Core``` of your project.

## Straight to the point 🎯<a name = "to_the_point"></a>

Alright! lets do this! 💪🏼

## <u>_Nginx_</u><br>

-  __What you need to know about NginX:__ \
Nginx is an open-source software, functioning initially as a web server, but it’s also used as a reverse proxy, HTTP cache, or a load balancer.\
Nginx is a web server which stores html, js, images files and use http request to display a website. The default configuration file of Nginx is nginx.conf and Nginx conf documents will be used to config our server and the right proxy connexion.

-  __Installation:__ \
The following commands will get the Nginx server running and it can be tested by opening a browser and  typing ``` localhost ```

```shell
> sudo apt update 
> sudo apt -y install nginx
> sudo systemctl enable nginx	#Enables Nginx to automatically start at boot time.
_____________________________________________________________________________________

> " installing Nginx in a container makes use of most of this commands but needs a personalized
configuration via config files. but if you simply want to test that it works outside a container
then use the following commands "
> sudo apt install ufw
> sudo sudo ufw allow 'Nginx HTTP'
```
- __Nginx Docker-file__ \
Be sure to run nginx in debug mode (foreground) and not as a daemon, so that Docker can track the process properly (otherwise your container will stop immediately after starting)!
```Docker 
CMD ["nginx", "-g" "daemon_off" 
```
 in the CMD in order for nginx to stay run in debug mode (foreground) and not as a daemon, so that Docker can track the process properly (otherwise your container will stop immediately after starting)!

- __*Useful commands*__:  
If these commands ask for sudo, simply add the user to the sudo and docker group

```shell
> docker-compose up				# runs the docker-compose file (builds all)
> docker built . -t name_of_image		# builds the docker image
> docker images					# Shows images built
> docker ps					# Shows containers running
> docker run -p 443:443 imageName		# To run and test without docker compose
> systemctl status ufw				# check if the firewall is up and active
> systemctl status nginx			# checks if nginx server is up and running
> service nginx start				# starts the server
> service nginx stop				# stops the server 
> cat /etc/nginx/nginx.conf			# this is the original config file of nginx

>"BE CAREFUL WHEN BUILDING IMAGES TO ALSO DELETE THEM TO SAVE SPACE, USE THIS COMAND TO DO THAT"

> docker rmi -f $(docker images -qa)
> docker rm -f $(docker ps -qa)

```

- __*TLS: configure TLS 1.2 and 1.3*__:

```TLS``` stands for ```Transport Layer Security ``` is a protocol for securing communication between the ```client``` and the ```Server```


In order to set the  TLS version we have to add  ___``` ssl_protocols TLSv1.2; ```___ into our ```nginx.conf```

## 💾 <u>_Wordpress_</u><br>
What are the steps to create your Wordpress

## Create you dockerfile image
- Download php-fpm
- Copy your own www.conf file into php/7.3/fpm/pool.d/
- Create the php directory to enable php-fpm to run
- Copy the script and launch it
- Go to the html directory
- Launch php-fpm

## Create a script
- Download Wordpress
- Create the configuration file of Wordpress
- Move files from Wordpress in the html directory
- Give the 4th environmental variables for Wordpress

## Create a www.conf 
You need to edit www.conf and place it in `/etc/php/7.3/fpm/pool.d` and `wp-content.php` to disable (7.3 is the usual version of php on a 42 VM) access to the Wordpress installation page when you access your site at https://login.42.fr
- Put listen = 0.0.0.0:9000 to listen to all ports
- Increase the number for the pm values in order to avoid a 502 page

__Installation:__

```shell
> sudo apt update && sudo apt install \		# Run updates and install php + extensions
	php-cli \
	php-fpm \
	php-json \
	php-pdo \
	php-mysql \
	php-zip \
	php-gd  \
	php-mbstring \
	php-curl \
	php-xml \
	php-pear \
	php-bcmath \ 
	curl
```

## <u>_MariaDB_</u><br>

-  __What you need to know about MariaDB:__ \


-  __Installation:__ \

```shell
> sudo apt update				# Run updates
> sudo apt install mariadb-server	# install Data base Service
> sudo mysql_secure_installation	# Ensure secure connection to data base
```

<br>
<br>

<p> <h2 align="center"><u>YOU MADE IT THROUGH <br> CONGRATULATIONS! 🎉<u/></h2>
<p align="center">
  <a href="" rel="noopener">
 <img src="https://tech.osteel.me/images/2020/03/04/docker-part-1-04.gif" alt="Project logo"></a>

<br>

## Resources <a name = "resources"></a>

______GENERAL______ 

<a name="lemp">LEMP Stack deployment

- https://www.digitalocean.com/community/tutorialshow-to-install-linux-nginx-mysql-php-lemp-stack-on-ubuntu-20-04

<a name="ssh">How to SSH into your VS code
- https://linuxhint.com/install-configure-linux-ssh/
- https://adamtheautomator.com/vs-code-remote-ssh

<a name="remotessh">VS code Extension for remote SSH connection 
- https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh

______DOCKER______

Learn about Docker
- https://www.youtube.com/watch?v=eGz9DS-aIeY
Learn how to make a Docker-compose file
- https://www.youtube.com/watch?v=DM65_JyGxCo 

<a name="learnmore1">Learn about `Dockerfile` commands and Syntax
- https://www.learnitguide.net/2018/06/dockerfile-explained-with-examples.html

Using variables in Docker compose
- https://betterprogramming.pub/using-variables-in-docker-compose-265a604c2006 

Some more Docker knowledge 
- https://blog.sourcerer.io/a-crash-course-on-docker-learn-to-swim-with-the-big-fish-6ff25e8958b0

______NGINX______

- http://nginx.org/en/docs/beginners_guide.html
- https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04
Use TSL V1.3 ONLY
- https://www.cyberciti.biz/faq/configure-nginx-to-use-only-tls-1-2-and-1-3/

*______WORDPRESS______*

- https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose
- https://www.cloudbooklet.com/install-wordpress-with-docker-compose-nginx-apache-with-ssl/