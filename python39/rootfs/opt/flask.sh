#!/bin/bash

# We load all environment variable defined in the .env file of the project since they are needed for running the Flask
# server.
export $(cat /var/www/.env | xargs)
/usr/local/bin/python /var/www/server.py &
echo $! > /run/flask.pid
