#!/bin/sh
set -e

# Assurer que les répertoires de MariaDB existent et ont les bonnes permissions
mkdir -p /var/run/mysqld /var/lib/mysql
chown -R mysql:mysql /var/run/mysqld /var/lib/mysql

echo "Starting MariaDB..."
exec su-exec mysql "$@"
