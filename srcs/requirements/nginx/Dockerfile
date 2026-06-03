FROM debian:bookworm

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
	nginx \
	openssl && \
	rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes \
	-newkey rsa:2048 \
	-keyout etc/nginx/ssl/key.key \
	-out etc/nginx/ssl/req.crt \
	-subj "/C=CH/ST=VD/L=Lausanne/O=42/OU=42/CN=samokhta.42.fr/UID=samokhta"

COPY conf/nginx.conf etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]