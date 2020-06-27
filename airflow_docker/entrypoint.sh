#!/usr/bin/env bash

# start mysql service
sudo service mysql start

# start sshd deamon
sudo service ssh start

# create airflow database mysql
sudo mysqladmin -u root -proot create airflow

#
sudo mysql -u root -proot -Bse "SET GLOBAL explicit_defaults_for_timestamp = 1"

# initialize database
sudo airflow initdb

# start airflow webserver
sudo airflow webserver -D

# start airflow scheduler
sudo airflow scheduler

exec "$@"
