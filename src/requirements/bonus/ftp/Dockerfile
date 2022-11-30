FROM debian:buster

RUN	apt-get update && apt-get upgrade && apt-get install -y vsftpd

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

COPY tools/server_ftp.sh /etc/server_ftp.sh
ENTRYPOINT ["sh", "/etc/server_ftp.sh"]