#!/bin/bash

# We load all environment variable defined in the .env file of the project since they are needed for running the Flask
# server.
export $(cat /var/www/.env | xargs)
cd /var/www && /usr/local/bin/python server.py &
echo $! > /run/flask.pid
