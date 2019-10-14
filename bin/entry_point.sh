#!/bin/bash

# Requires: .credentials/resource_access_credentials.yml

# --------------------------------------------
# This script is the entry point script for 
# the project.
#
# To run this script you please ensure you have
# the correct hostname to enter the cluster
# in the credential file
#
# To enable no input - setup private key ssh 
# access
# 
# Please ensure you have set up SSH-free login
# with a public key
#
# Author: Vivek Katial
# --------------------------------------------

# Trigger errors
set -e;

# Find number of cols 
COLUMNS=$(tput cols) 

# Print welcome message
title="Hello! Welcome to the experimentr!"

# Print header
printf "=%.0s" $(seq 1 $COLUMNS)
printf "\n\n%*s\n\n" $(((${#title}+$COLUMNS)/2)) "$title"
printf "=%.0s" $(seq 1 $COLUMNS)

# include parse_yaml function
. bin/parse_yaml.sh

# read resource access credentials yaml file
eval $(parse_yaml .credentials/resource_access_credentials.yml)

# SSH into cluster and run main script
cat bin/create-experiments.sh | ssh -tt $credentials_hostname

# End Script

# Print ending message
# Print header
footer="Jobs complete!"

printf "=%.0s" $(seq 1 $COLUMNS)
printf "\n\n%*s\n\n" $(((${#title}+$COLUMNS)/2)) "$footer"
printf "=%.0s" $(seq 1 $COLUMNS)

printf -- '\n';
exit 0;