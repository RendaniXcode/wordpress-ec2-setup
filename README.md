# WordPress EC2 Setup

This repository contains a userdata script for setting up WordPress on an AWS EC2 instance.

## Usage

1. Launch a new EC2 instance and copy the content of `userdata.sh` into the User data field.
2. Make sure the security group allows HTTP traffic.
3. After the instance starts, WordPress should be accessible at `http://<your-ec2-ip-address>`.

## What the Script Does

The `userdata.sh` script performs the following steps:

1. Updates the system's package index.
2. Installs Apache and MySQL server.
3. Runs a MySQL secure installation script to set the root password and remove unnecessary users and test databases.
4. Creates a new MySQL database and user for WordPress and grants all privileges on the new database to the new user.
5. Installs PHP.
6. Downloads the latest version of WordPress.
7. Extracts the WordPress archive and moves the WordPress files to the Apache default root directory.
8. Sets the ownership and permissions for the WordPress files and directories.
9. Creates the `wp-config.php` file from the sample provided by WordPress, replacing the placeholder values with the actual values for the database name, user, password, and host.
10. Restarts the Apache server to load the new configuration.

## Note

This script is suitable for small to medium-sized sites. For larger sites with heavy traffic, a more scalable infrastructure setup, such as running MySQL on a separate server or using a managed database service like Amazon RDS, would be more appropriate.
