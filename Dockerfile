FROM debian:buster
MAINTAINER Yves de Montbrun <yde-mont@student.42.fr>

#COPY ft_server.sh .
#CMD bash ft_server.sh

RUN	apt-get update;  \
	apt-get upgrade -y; \
	apt-get install -y wget

RUN	apt-get install -y mariadb-server

RUN phpmyadmin

RUN	apt-get install libnss3-tools -y; \
	mkdir ~/mkcert; \
	cd ~/mkcert; \
	wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64; \
	mv mkcert-v1.4.3-linux-amd64 mkcert; \
	chmod +x mkcert; \
	./mkcert -install; \
	./mkcert localhost 127.0.0.1