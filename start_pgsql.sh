#!/bin/bash

if [[ ! -f /opt/postgresql/initialized ]]; then
    mkdir -p /opt/postgresql
    cp -a /var/lib/postgresql/* /opt/postgresql/
    chown -R postgres:postgres /opt/postgresql
    su postgres sh -c "/usr/lib/postgresql/9.4/bin/postgres --single  -D  /var/lib/postgresql/9.4/main  -c config_file=/etc/postgresql/9.4/main/postgresql.conf" <<< "CREATE USER root WITH SUPERUSER PASSWORD '$1';"
    su postgres sh -c "/usr/lib/postgresql/9.4/bin/postgres --single  -D  /var/lib/postgresql/9.4/main  -c config_file=/etc/postgresql/9.4/main/postgresql.conf" <<< "CREATE DATABASE db ENCODING 'UTF8' TEMPLATE template0;"
    touch /opt/postgresql/initialized
fi
su postgres sh -c "/usr/lib/postgresql/9.4/bin/postgres           -D  /var/lib/postgresql/9.4/main  -c config_file=/etc/postgresql/9.4/main/postgresql.conf  -c listen_addresses=*"
