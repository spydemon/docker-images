#!/usr/bin/env sh

# Simple wrapper around the docker-compose command.

function start {
	`docker-compose up -d`;
}

function stop {
	`docker-compose down`;
}

function help {
	cat <<EOF
$0 usage:
 restart: restart the project
 start:   start the project
 stop:    stop the project

Note: don't forget to go to your docker-compose project folder before running the command.
EOF
}

case $1 in
	start)
		start;
		;;
	stop)
		stop;
		;;
	restart)
		stop;
		start;
		;;
	*)
		help;
		;;
esac
