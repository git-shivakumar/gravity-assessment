#!/bin/bash
sudo apt update -y &&
sudo apt install -y nginx
echo "Hello Nginx from Gravity" > /var/www/html/index.html
