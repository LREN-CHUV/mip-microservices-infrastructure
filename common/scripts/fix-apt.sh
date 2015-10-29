#!/bin/sh

# Run this script when there are errors such as 'Hash Sum mismatch' during apt-get update.

echo "Remove old package sources"
sudo rm -f /etc/apt/sources.list.d/docker.list

echo "Clean apt lists"
sudo rm -rf /var/lib/apt/lists/*

echo "Update apt cache"
sudo apt-get update
