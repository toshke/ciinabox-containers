#!/bin/sh -x
set -e

#Pick up groupId for docker socket
DOCKER_SOCK_GROUP_ID=`stat -c '%g' /var/run/docker.sock`
DOCKER_GROUP="docker"
JENKINS_USER="jenkins"

#Add docker group if it does not exist
if [ grep -q -E "^$DOCKER_GROUP:" /etc/group  ]; then
	echo "Docker group already exists"
else
	groupadd -for -g $DOCKER_SOCK_GROUP_ID $DOCKER_GROUP
	usermod -aG $DOCKER_GROUP $JENKINS_USER
fi

/usr/sbin/sshd -D


#No need for starting docker, as we'll use host's docker system
