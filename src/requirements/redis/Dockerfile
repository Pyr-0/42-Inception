
FROM debian:buster

EXPOSE 6379

RUN	apt-get update && apt-get upgrade && apt-get  install -y redis && \
	rm -rf /var/lib/apt/lists/*


COPY tools/conf.sh /tmp/conf.sh
ENTRYPOINT ["sh", "/tmp/conf.sh"]