FROM alpine:3.16

# Install MariaDB and necessary tools
RUN apk update && apk add --no-cache mariadb mariadb-client gettext su-exec

# Create necessary directories
RUN mkdir -p /var/lib/mysql /run/mysqld

# Copy the custom MariaDB configuration
COPY conf/my.cnf /etc/my.cnf

# Copy the entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Adjust permissions
RUN chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Expose MariaDB port
EXPOSE 3306

# Define the entrypoint and default command
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["mysqld", "--datadir=/var/lib/mysql"]
