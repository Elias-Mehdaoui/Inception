FROM alpine:3.22

RUN apk update && apk add --no-cache mariadb mariadb-client mariadb-server-utils

RUN mkdir -p /run/mysqld /var/lib/mysql /var/log/mysql && \
	chown -R mysql:mysql /run/mysqld /var/lib/mysql /var/log/mysql

COPY conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY tools/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 3306

HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
	CMD mariadb-admin ping -h localhost --silent || exit 1

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
