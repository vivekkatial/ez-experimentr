#!/bin/bash

# --------------------------------------------
# This script is builds the mlflow container
#
# Author: Vivek Katial
# --------------------------------------------

set -e

# Check if AWS directory exists
if [ -d .aws/ ] ; then 
    echo "AWS directory present"
else
    echo "AWS directory is not present"
    exit 1
fi

# First check if AWS credentials are present
if [ ! -e .aws/credentials ] ; then
    echo "Could not locate AWS credentials please ensure you have transferred them" 
    echo "Try using SCP: 'scp -i ~/.ssh/<VM_PEM_KEY.pem> .aws/ ubuntu@<VM_URI>:ez-experimentr/' "
    exit 1
fi

# Check if env.list exists
if [ -e ./env.list ] ; then 
    echo "Environment file is present"
else
    echo "Environment file is not present"
    exit 1
fi

echo "Building MLFLOW container"

# Build container
docker build -f Dockerfile-mlflow -t ez-experimentr/mlflow .