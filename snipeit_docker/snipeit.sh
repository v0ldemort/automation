#!/bin/bash

sudo touch my_env my_env_file
sudo chmod 0707 my_env my_env_file
cat <<EOF >> my_env_file
# Mysql Parameters
MYSQL_ROOT_PASSWORD=root
MYSQL_DATABASE=snipeit
MYSQL_USER=snipeit
MYSQL_PASSWORD=root

# Email Parameters
# - the hostname/IP address of your mailserver
MAIL_PORT_587_TCP_ADDR=smtp.whatever.com
#the port for the mailserver (probably 587, could be another)
MAIL_PORT_587_TCP_PORT=587
# the default from address, and from name for emails
MAIL_ENV_FROM_ADDR=youremail@yourdomain.com
MAIL_ENV_FROM_NAME=Your Full Email Name
# - pick 'tls' for SMTP-over-SSL, 'tcp' for unencrypted
MAIL_ENV_ENCRYPTION=tcp
# SMTP username and password
MAIL_ENV_USERNAME=your_email_username
MAIL_ENV_PASSWORD=your_email_password

# Snipe-IT Settings
APP_ENV=production
APP_DEBUG=false
APP_KEY=dockerkey
APP_URL=http://127.0.0.1:80
APP_TIMEZONE=US/Pacific
APP_LOCALE=en
EOF

sed "s/dockerkey/$(docker run --rm snipe/snipe-it:v4.7.3 | grep base64)/" my_env_file > my_env
docker run --name snipe-mysql --env-file=my_env --mount source=snipesql-vol,target=/var/lib/mysql -d -P mysql:5.6
docker run -d -p 8081:80 --name="snipeit" --link snipe-mysql:mysql --env-file=my_env --mount source=snipe-vol,dst=/var/lib/snipeit snipe/snipe-it:v4.7.3
sleep 30
#docker exec -i snipe-mysql /usr/bin/mysql -u root --password=root snipeit < >backupfile.sql< 
