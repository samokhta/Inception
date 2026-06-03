#!/bin/sh

# Initialize the database directory if empty
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Start MariaDB temporarily to run setup commands
mysqld_safe --skip-networking &

until mysqladmin ping --silent
do
    sleep 1
done

# Create database and user
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
EOF

# Stop the temporary instance
mysqladmin shutdown

# Start MariaDB properly, listening on all interfaces
exec mysqld_safe --bind-address=0.0.0.0