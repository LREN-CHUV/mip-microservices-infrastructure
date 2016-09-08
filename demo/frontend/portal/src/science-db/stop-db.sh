#!/bin/bash -e

if groups $USER | grep &>/dev/null '\bdocker\b'; then
    DOCKER="docker"
else
    DOCKER="sudo docker"
fi

$DOCKER stop analyticsdb > /dev/null
$DOCKER rm analyticsdb > /dev/null
