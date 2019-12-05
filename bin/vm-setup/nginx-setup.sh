#!bin/bash

# --------------------------------------------
# Install nGINX reverse proxy on the VM for 
# mlflow
#
# Author: Vivek Katial
# --------------------------------------------

export USER_NAME="vivek"

# Install nGINX
sudo apt-get update && sudo apt-get -y install nginx

# Installing Apache Tools
sudo apt-get install apache2-utils

# Setting Up HTTP Basic Authentication Credentials (try "test123")
sudo htpasswd -c /etc/nginx/.htpasswd $USER_NAME

# Add the following
# server {
#     listen       80;
#     location / {
#         proxy_pass http://localhost:5000/;
#         auth_basic "Restricted Content";
#         auth_basic_user_file /etc/nginx/.htpasswd;
#   } 
# }

# Updating the Nginx Configuration
sudo nano /etc/nginx/nginx.conf

# Firewall stuff
# sudo ufw status
# # Enable
# sudo ufw enable
#  # Allow 80
# sudo ufw allow http
#  # Allow SSh
# sudo ufw allow ssh

# # Allow 443
# sudo ufw status numbered


