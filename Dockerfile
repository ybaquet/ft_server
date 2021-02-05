FROM debian:buster
MAINTAINER Yves Baquet <ybaquet@nowhere.null>

RUN	apt-get update;  \
	apt-get upgrade -y; \
	apt-get install -y wget; \
	apt-get install -y vim; \
	apt-get install -y nginx; \
	apt-get install -y supervisor

RUN	apt-get install libnss3-tools -y; \
	mkdir ~/mkcert; \
	cd ~/mkcert; \
	wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64; \
	mv mkcert-v1.4.3-linux-amd64 mkcert; \
	chmod +x mkcert; \
	./mkcert -install; \
	./mkcert localhost 127.0.0.1

#phpMyAdmin
ARG PHP_VERSION=7.3
WORKDIR /root/download
RUN	apt-get install -y php${PHP_VERSION}-fpm php${PHP_VERSION}-mysql php${PHP_VERSION}

RUN	wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz; \
	tar xf phpMyAdmin-5.0.4-all-languages.tar.gz -C /var/www/html/; \
	mv /var/www/html/phpMyAdmin-5.0.4-all-languages /var/www/html/phpMyAdmin; \ 
	sed -i 's/;   extension=mysqli/;   extension=mysqli/g'  /etc/php/${PHP_VERSION}/fpm/php.ini; \
	sed -i 's:;extension_dir = "./":extension_dir = "/usr/lib/php/20180731":g' /etc/php/${PHP_VERSION}/fpm/php.ini

RUN	service php${PHP_VERSION}-fpm start

#WordPress
RUN	wget https://wordpress.org/latest.tar.gz; \
	tar xf latest.tar.gz -C /var/www/html/

#MySql
COPY ./srcs/init_database.sh /root/download/.
RUN	apt-get install -y mariadb-server


#expose http https
EXPOSE 80 443

COPY ./srcs/wp-config.php /var/www/html/wordpress/.
COPY ./srcs/default /etc/nginx/sites-available/default
COPY ./srcs/index.nginx-debian.html /var/www/html/index.nginx-debian.html
COPY ./srcs/index.nginx-debian.html /var/www/html/index.nginx-debian.html
COPY ./srcs/supervisor.conf /etc/supervisor.conf

CMD ["supervisord", "-c", "/etc/supervisor.conf"]
