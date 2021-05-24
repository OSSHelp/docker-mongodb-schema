#!/bin/bash
# shellcheck disable=SC2086


check_mongodb_is_available() {
	echo "{ping: 1}" | mongo "mongodb://${MONGODB_USER}:${MONGODB_PASSWORD}@${MONGODB_HOST}:${MONGODB_PORT}" >/dev/null
}

create_dbs_and_users() {
	for db in ${MONGODB_DBS//,/ }; do
		echo "{ping: 1}" | mongo "mongodb://${db%%:*}:${db#*:}@${MONGODB_HOST}:${MONGODB_PORT}/${db%%:*}" >/dev/null \
		&& { echo "The db ${db%%:*} exists. Skipping"; continue; }

		echo "use ${db%%:*}" > /tmp/create_db_and_user.js
		echo "db.createUser({user: \"${db%%:*}\", pwd: \"${db#*:}\", roles: [\"dbOwner\"]})" >> /tmp/create_db_and_user.js
		mongo "mongodb://${MONGODB_USER}:${MONGODB_PASSWORD}@${MONGODB_HOST}:${MONGODB_PORT}" < /tmp/create_db_and_user.js
	done
}

until check_mongodb_is_available; do
	sleep 1
	(( MONGODB_TIMEOUT-- ))
	test $MONGODB_TIMEOUT -eq 0 && { echo "ERROR. MongoDB is unavailable ${MONGODB_HOST}:${MONGODB_PORT}"; exit 1;}
done

create_dbs_and_users
