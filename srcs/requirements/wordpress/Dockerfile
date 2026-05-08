FROM alpine:3.22

RUN apk update && apk add --no-cache \
    php83 php83-fpm php83-mysqli \
    php83-phar php83-mbstring php83-curl \
    php83-iconv php83-tokenizer \
    php83-session php83-ctype \
    mariadb-client wget tar

RUN ln -sf /usr/bin/php83 /usr/bin/php

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html /var/log/php83
RUN chown -R nobody:nobody /var/www/html

COPY conf/www.conf /etc/php83/php-fpm.d/www.conf
COPY tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

WORKDIR /var/www/html

RUN echo "memory_limit = 256M" >> /etc/php83/conf.d/00_custom.ini

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
