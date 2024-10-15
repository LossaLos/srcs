FROM debian:11

ENV DEBIAN_FRONTEND=noninteractive
ARG MYSQL_DATABASE=;
ARG MYSQL_USER=;
ARG MYSQL_PASSWORD=;
ARG MYSQL_ROOT_PASSWORD=;

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/*

# repo for mysql
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 777 /var/run/mysqld

# init db
RUN	service mariadb start \
&& mysql -u root -e "CREATE DATABASE ${MYSQL_DATABASE};" && \
mysql -u root -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" && \
mysql -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';" && \
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

EXPOSE 3306

CMD ["mysqld", "--bind-address=0.0.0.0"]