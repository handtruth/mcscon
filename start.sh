#!/bin/bash

umask 002

if [ ! -f server.jar ]; then
	/setup-vanilla.sh
	result=$?
	if [ $result != 0 ]; then
		exit 1
	fi
fi

java $JAVA_ARGS -jar server.jar nogui
