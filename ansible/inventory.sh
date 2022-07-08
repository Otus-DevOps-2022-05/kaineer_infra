#!/bin/bash

if [ -f "./servers.yml" ]; then
	APPSERVER=$(cat ./servers.yml | grep app | cut -f2 -d" ")
	DBSERVER=$(cat ./servers.yml | grep db | cut -f2 -d" ")
fi

output_list_json() {
	echo '{"all": {"children": ["app", "db"]},'
	echo " \"db\": [\"${DBSERVER}\"],"
	echo " \"app\": [\"${APPSERVER}\"]"
	echo '}'
}

case "$1" in
	"--list") output_list_json ;;
	"--host") echo "{}" ;;
esac
