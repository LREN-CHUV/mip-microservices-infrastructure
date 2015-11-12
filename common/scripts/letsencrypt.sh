#!/bin/bash

domain=$1
email=$2
email=${email:-ludovic.claude54@gmail.com}

mkdir -p $domain/{etc,data,log}

docker run -it --rm -p 443:443 -p 80:80 --name letsencrypt \
    -v "$(pwd)/$domain/etc:/etc/letsencrypt" \
    -v "$(pwd)/$domain/data:/var/lib/letsencrypt" \
    -v "$(pwd)/$domain/log:/var/log/letsencrypt" \
    quay.io/letsencrypt/letsencrypt:latest certonly --authenticator manual \
	--agree-dev-preview --server https://acme-v01.api.letsencrypt.org/directory \
	--email $email --agree-tos --rsa-key-size 4096 \
	--renew-by-default --domain $domain
