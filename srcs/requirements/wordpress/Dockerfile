FROM debian:bookworm

RUN 	apt-get update && \
		apt-get upgrade -y && \
		apt-get install -y \
		wget \
		curl \
		php8.2-fpm \
		php8.2-mysql && \
		rm -rf /var/lib/apt/lists/*

RUN		curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN		chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY	./conf/www.conf /etc/php/8.2/fpm/pool.d/

WORKDIR /var/www/html/

COPY	./tools/create_wordpress.sh /usr/local/bin/
RUN		chmod +x /usr/local/bin/create_wordpress.sh
ENTRYPOINT ["/usr/local/bin/create_wordpress.sh"]

EXPOSE 9000

CMD ["/usr/sbin/php-fpm8.2", "-F"]