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
set -e # Exit on first error
#set -v # Verbose

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

# read experiment configuration
eval $(parse_yaml config/experiment_config.yml)

# Copy experimental configuration into cluster location
cluser_path="$credentials_hostname:"

# Copy configuration file into cluster
echo "Copying Experimental Configuration file from LOCAL to $cluser_path on CLUSTER"
scp config/experiment_config.yml $cluser_path

# Copy helper function into cluster
echo "Copying YAML reading helper function from LOCAL to $cluser_path on CLUSTER"
scp bin/parse_yaml.sh $cluser_path

# SSH into cluster and run bash script to create experimental files
cat bin/create_experiments.sh | ssh -tt $credentials_hostname

# Run experiments in ready folder 
# TO:DO Check if previous slurm job is completer
# Provision experiments to run!

# Print ending message
footer="Experimental Setup Complete!"

printf "=%.0s" $(seq 1 $COLUMNS)
printf "\n\n%*s\n\n" $(((${#title}+$COLUMNS)/2)) "$footer"
printf "=%.0s" $(seq 1 $COLUMNS)
printf -- '\n';

exit 0;