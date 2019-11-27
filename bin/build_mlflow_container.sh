#!/bin/bash

# --------------------------------------------
# This script is builds the mlflow container
#
# Author: Vivek Katial
# --------------------------------------------

set -e

# Check if AWS directory exists
if [ ! -d  -e ".aws/" ]; then
    echo "Please create AWS directory"
fi

# First check if AWS credentials are present
if [ ! -e .aws/credentials ] ; then
    echo "Could not locate AWS credentials please ensure you have transferred them" 
    echo "Try using SCP: 'scp -i ~/.ssh/<VM_PEM_KEY.pem> .aws/ ubuntu@<VM_URI>:ez-experimentr/' "
    exit 1
fi

echo "Building MLFLOW container"

# Build container
docker build -f Dockerfile-mlflow -t ez-experimentr/mlflow .