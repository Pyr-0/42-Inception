<br><h2 align="center"><u>42 INCEPTION - INSTRUCTIVE GUIDE</u></h1>
<p align="center">
  <a href="" rel="noopener">
 <img width=100px height=100px src="https://i.pinimg.com/originals/70/b2/f1/70b2f130bdb8d52c11eb69b83beef20e.gif" alt="Project logo"></a>
</p>

<div align="center">

[![License: WTFPL](https://img.shields.io/badge/License-WTFPL-brightgreen.svg)](http://www.wtfpl.net/about/)

[![License: CC0-1.0](https://licensebuttons.net/l/zero/1.0/80x15.png)](http://creativecommons.org/publicdomain/zero/1.0/)
</div>

---
## 📝 Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Contents](#contents)
- [Contributing](../CONTRIBUTING.md)

## About <a name = "about"></a>

This guide intends to Log my step by step  into deploying a multi-dockerized server structure  using Nginx, Mariadb mysql, and Wordpress.

## Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See [deployment](#deployment) for notes on how to deploy the project on a live system.

### NginX
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

## Resources <a name = "resources"></a>

__DOCKER__

- https://www.learnitguide.net/2018/06/dockerfile-explained-with-examples.html

__NGINX__

- http://nginx.org/en/docs/beginners_guide.html
- https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04