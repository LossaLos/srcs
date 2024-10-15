# srcs/requirements/wordpress/Dockerfile

FROM alpine:3.16

RUN apk update && apk add --no-cache \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-json \
    php81-session \
    php81-gd \
    php81-curl \
    php81-xml \
    php81-mbstring \
    php81-opcache \
    php81-zlib \
    php81-pdo \
    php81-pdo_mysql \
    php81-tokenizer \
    php81-phar \
    mariadb-client \
    curl \
    tar \
    bash

# Définir le PATH pour inclure /usr/bin
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Créer un lien symbolique pour php
RUN ln -s /usr/bin/php81 /usr/bin/php

# Vérifier si le groupe www-data existe, sinon le créer
RUN getent group www-data || addgroup -S www-data

# Vérifier si l'utilisateur www-data existe, sinon le créer
RUN getent passwd www-data || adduser -S -g www-data www-data

# Créer le répertoire pour WordPress
RUN mkdir -p /var/www/html

# Changer les permissions pour que www-data ait accès aux fichiers
RUN chown -R www-data:www-data /var/www/html

# Installer wp-cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
    
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf
    # Copier le script d'entrée
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Définir le répertoire de travail
WORKDIR /var/www/html

# Exposer le port utilisé par php-fpm
EXPOSE 9000

ENTRYPOINT ["docker-entrypoint.sh"]

# Démarrer php-fpm avec le chemin correct
CMD ["php-fpm81", "-F"]
