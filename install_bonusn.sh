#!/bin/bash

sudo apt-get install nginx apache2-utils
sudo htpasswd -c /etc/nginx/htpasswd.users admin
# sudo vi /etc/nginx/sites-available/default
# server {
#    listen 80;
#
#    server_name example.com;
#
#    auth_basic "Restricted Access";
#    auth_basic_user_file /etc/nginx/htpasswd.users;
#
#    location / {
#        proxy_pass http://localhost:5601;
#        proxy_http_version 1.1;
#        proxy_set_header Upgrade $http_upgrade;
#        proxy_set_header Connection 'upgrade';
#        proxy_set_header Host $host;
#        proxy_cache_bypass $http_upgrade;
#    }
#}
