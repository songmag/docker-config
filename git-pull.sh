#!/bin/sh

DOCKER_PATH=~/docker-compose-file/mark

TOKEN=`sudo cat ~/.config/gh/hosts.yml | grep token | awk -F ':' '{print $2}' | xargs echo `

if [ -z $TOKEN ] 
then
	echo 'Login 후 진행 해주세요'
	brew install gh 
	if [ $? -eq 0 ]
	then
		echo "github install finish"
	fi
	gh auth login
	TOKEN=`sudo cat ~/.config/gh/hosts.yml | grep token | awk -F ':' '{print $2}' | xargs echo `
fi

mkdir -p $DOCKER_PATH && curl -H "Authorization: token $TOKEN" https://raw.githubusercontent.com/songmag/docker-config/main/docker-compose.yml > $DOCKER_PATH/docker-compose.yml 
echo $? 
if [ $? -eq 0 ]
then
	cat $DOCKER_PATH/docker-compose.yml
	docker-compose -f $DOCKER_PATH/docker-compose.yml up -d
fi
