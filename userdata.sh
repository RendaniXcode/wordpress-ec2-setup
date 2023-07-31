#!/bin/bash

# Update the system
apt-get update -y

# Install Apache
apt-get install apache2 -y

# Install MySQL Server
DEBIAN_FRONTEND=noninteractive apt-get install mysql-server -y

# Start MySQL Service
systemctl start mysql

# Run MySQL Secure Installation non-interactively
mysql --execute="UPDATE mysql.user SET Password=PASSWORD('PASS4sure5') WHERE User='root'; DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1'); DELETE FROM mysql.user WHERE User=''; DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%'; FLUSH PRIVILEGES;"

# Create a new MySQL user and database for WordPress
mysql --execute="CREATE DATABASE wordpress; CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'PASS4sure5'; GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost'; FLUSH PRIVILEGES;"

# Install PHP
apt-get install php libapache2-mod-php php-mysql -y

# Download WordPress
wget https://wordpress.org/latest.tar.gz

# Extract WordPress
tar xzvf latest.tar.gz

# Move WordPress files to the Apache default root directory
cp -R wordpress/* /var/www/html/

# Set permissions
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

# Configure WordPress
cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/database_name_here/wordpress/g" /var/www/html/wp-config.php
sed -i "s/username_here/wordpress/g" /var/www/html/wp-config.php
sed -i "s/password_here/PASS4sure5/g" /var/www/html/wp-config.php
sed -i "s/localhost/localhost/g" /var/www/html/wp-config.php

# Restart Apache to load the new configuration
systemctl restart apache2
