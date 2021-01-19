FROM debian:buster
MAINTAINER Yves de Montbrun <yde-mont@student.42.fr>

#COPY ft_server.sh .
#CMD bash ft_server.sh

RUN	apt-get update;  \
	apt-get upgrade -y
#	apt-get install -y mariadb-server

RUN	apt-get install -y wget; \
	apt-get install libnss3-tools -y; \
	wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64; \

ls -l
