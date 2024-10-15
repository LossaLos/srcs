FROM debian:11

RUN apt-get update && apt-get -y install \
    php \
    php-mysql \
    php-fpm \
    php-pdo \
    && rm -rf /var/lib/apt/lists/*

# cpy conf file
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# create php start repo
RUN mkdir /run/php

# cpy script and change access
COPY ./tools/create_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wordpress.sh

ENTRYPOINT ["/usr/local/bin/create_wordpress.sh"]

WORKDIR /var/www/html/

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]
