<br><h2 align="center"><u>42 INCEPTION - INSTRUCTIVE GUIDE</u></h1>
<p align="center">
  <a href="" rel="noopener">
 <img width=100px height=100px src="https://i.pinimg.com/originals/70/b2/f1/70b2f130bdb8d52c11eb69b83beef20e.gif" alt="Project logo"></a>
</p>

<div align="center">

[![License: WTFPL](https://img.shields.io/badge/License-WTFPL-brightgreen.svg)](http://www.wtfpl.net/about/) [![License: CC0-1.0](https://licensebuttons.net/l/zero/1.0/80x15.png)](http://creativecommons.org/publicdomain/zero/1.0/)
</div>

---
## 📝 Table of Contents

- [About](#about)
- [Suggestions](#sugestions)
- [Getting Started](#getting_started)
- [Straight to the point](#straight_to_the_point)
- [Nginx](#nginx)
- [Resources](#resources)

## 📓 About <a name = "about"></a>

Inception is a project about Docker containers, this will help expand knowledge about system administration and some Web development skills as well.\
\
This project can also be understood under the name of <u>```LEMP Stack Deployment``` 
<sup>[learn more](#lemp)</sup> </u> 

A <mark>LEMP</mark> stack is the foundation upon which websites are built, leveraging NGINX instead of Apache as its web server. It is made up of four components that grant its name - Linux, NGINX (pronounced Engine X), MySQL, and PHP-FPM. Linux is the operating system, NGINX is the web server, MySQL is the database, and PHP-FPM interprets code to produce dynamic content. In this article, we will walk you through installing and configuring a basic LEMP stack.
This guide intends to Log my step by step  into deploying a multi container website in Wordpress Nginx server, and  MariaDB.\
These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.</k>


## 🤖 Suggestions

This project carries a lot of diverse topics, and with them `A LOT of documentation, for that reason I created this guide, to have the [Resources](#resources) necessary for you to get some information about each topic and hopefully save some hours and avoid falling down the rabbit hole of material that one can find online. \
as for the line of order for developing the project I want to suggest some points that helped me to not get lost and learn comfortably and move forward quicker. (this are tips that help me but are not necessary to follow, so feel free to find what its best for you  ✌🏼) 

1. <u>Use a `SSH connection` </u> between your VM and your work station (___specially if you are working at 42 campus with limited ram on your VM___), For this my choice was to use the extension  for __Visual Studio code__ called `Remote - SSH` . <br>

<img width=700px height=500px src="https://securityjournalblog.files.wordpress.com/2019/11/ssh-readme.gif" ></a>

This will make it  easier to work on the project if you like, for example, opening multiple files while also navigating through the folder structure of your machine.<br> 
	__Link for the extension:__
https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh

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

## Getting Started <a name = "getting_started"></a>

<u>_Setting up a Virtual Machine_</u>

The first step for this project is obviously to get your hands on a ```virtual machine``` with any Linux distribution. In this machine you will need to install ``` Docker && Docker-compose``` and setup the according ```sudo permissions``` necessary for your user to work.

`sudo adduser user_name`

`sudo usermod -aG sudo user_name`

`sudo usermod -aG docker user_name`

`sudo usermod -aG vboxsf user_name (if you use shared folders on your vm)`

<u>_Get Familiar with Docker_</u>

It will be important that you start getting familiar with Docker and with the syntax of Docker Files and of Docker-compose. this two files are basically the ```Core``` of your project.

### Nginx
-  __What you need to know about NginX:__ \
Nginx is an open-source software, functioning initially as a web server, but it’s also used as a reverse proxy, HTTP cache, or a load balancer.\
Nginx is a web server which stores html, js, images files and use http request to display a website. The default configuration file of Nginx is nginx.conf and Nginx conf documents will be used to config our server and the right proxy connexion.

-  __Installation:__ \
The following commands will get the Nginx server running and it can be tested by opening a browser and  typing ``` localhost ```

```bash
sudo apt update 
sudo apt -y install nginx
sudo systemctl enable nginx		#Enables Nginx to automatically start at boot time.
_____________________________________________________________________________________

# installing Nginx in a container makes use of most of this commands but needs a personalized configuration via config files. but if you simply want to test that it works outside a container then use the following commands 
sudo apt install ufw
sudo sudo ufw allow 'Nginx HTTP'
```
- __*DOCKERFILE*__:\
Now we have to create a dockerfile in order to install our nginx in a single container, so here is a summary of some useful syntax used to write a dockerfile:

```Docker
FROM - instruction used to specify the valid docker image name. So specified Docker Image will be downloaded from docker hub registry if it is not exists locally.

RUN - This runs a Linux command. Used to install packages into container, create folders, etc.

COPY - instruction is used to copy files, directories and remote URL files to the destination within the filesystem of the Docker Images. 

EXPOSE -  instruction is used to inform about the network ports that the container listens on runtime. Docker uses this information to interconnect containers using links and to set up port redirection on docker host system.

CMD - allows you to set a default command which will be executed only when you run a container without specifying a command. 

```


- __*Useful commands*__:

```bash
#If comands ask for sudo, add user to sudo and docker group
docker-compose up					# runs the docker-compose file (builds all)
docker built . -t name_of_image	# builds the docker image
docker images						# Shows images built
docker ps						# Shows containers running
docker run -p 443:443 imageName	# To run and test without docker compose
systemctl status ufw				# check if the firewall is up and active
systemctl status nginx				# checks if nginx server is up and running
service nginx start				# starts the server
service nginx stop					# stops the server 
cat /etc/nginx/nginx.conf				# this is the original config file of nginx
#BE CAREFUL WHEN BUILDING IMAGES TO ALSO DELETE THEM TO SAVE SPACE, USE THIS COMAND TO DO THAT
sudo docker rmi -f $(sudo docker images -qa) && sudo docker rm -f $(sudo docker ps -qa) 

```

- __*TLS: configure TLS 1.2 and 1.3*__:

```TLS``` stands for ```Transport Layer Security ``` is a protocol for securing communication between the ```client``` and the ```Server```


In order to set the  TLS version we have to add  ___``` ssl_protocols TLSv1.2; ```___ into our ```nginx.conf```

- __CMD in NGINX__

	If you add a custom CMD in the Docker-file, be sure to include -g daemon off; in the CMD in order for nginx to stay in the foreground, so that Docker can track the process properly (otherwise your container will stop immediately after starting)!

### MariaDB

-  __What you need to know about MariaDB:__ \


-  __Installation:__ \

`sudo apt update
sudo apt install mariadb-server
sudo mysql_secure_installation`

## Resources <a name = "resources"></a>

__GENERAL__ 

<a name="lemp">1</a>: LEMP

- https://www.digitalocean.com/community/tutorialshow-to-install-linux-nginx-mysql-php-lemp-stack-on-ubuntu-20-04

How to SSH into your VS code
- https://adamtheautomator.com/vs-code-remote-ssh


- https://adamtheautomator.com/vs-code-remote-ssh

__DOCKER__

Learn how to make a Docker-compose file
- https://www.youtube.com/watch?v=DM65_JyGxCo 

Learn about `Dockerfile` commands and Syntax
- https://www.learnitguide.net/2018/06/dockerfile-explained-with-examples.html

Using variables in Docker compose
- https://betterprogramming.pub/using-variables-in-docker-compose-265a604c2006 

Some more Docker knowledge 
- https://blog.sourcerer.io/a-crash-course-on-docker-learn-to-swim-with-the-big-fish-6ff25e8958b0

__NGINX__

- http://nginx.org/en/docs/beginners_guide.html
- https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04

__WORDPRESS__

- https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-docker-compose
- https://www.cloudbooklet.com/install-wordpress-with-docker-compose-nginx-apache-with-ssl/