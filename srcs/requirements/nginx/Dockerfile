FROM debian:11

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && apt-get clean

# socket repo
RUN mkdir -p /run/nginx

# index.html repo
RUN mkdir -p /var/www/html

# certif repo creation
RUN mkdir -p /etc/ssl/certs /etc/ssl/private

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/ssl/private/nginx-selfsigned.key \
        -out /etc/ssl/certs/nginx-selfsigned.crt \
        -subj "/C=FR/ST=Lyon/L=Lyon/O=42 School/OU=fprevot/CN=fprevot"

# cpy conf of nginx
COPY ./conf/nginx.conf /etc/nginx/conf.d
COPY ./tools/fastcgi_params /etc/nginx/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]