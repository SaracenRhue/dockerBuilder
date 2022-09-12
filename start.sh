#!/bin/bash

sudo systemctl start docker

echo "enter your docker username"
read username
echo "Hello, $name"

echo "enter your docker password"
read passwd

docker login -u $username -p $passwd

echo "enter your docker image name"
read imagename
echo $imagename

docker buildx ls

echo "do you neeed a new builder? (y/n)"
read answer
if [ $answer == "y" ]
then
    docker buildx create --name mybuilder
fi

docker buildx use mybuilder
docker buildx inspect --bootstrap
docker run -it --rm --privileged tonistiigi/binfmt --install all
docker buildx build --platform linux/amd64,linux/arm64 -t $username/$imagename:latest . --push