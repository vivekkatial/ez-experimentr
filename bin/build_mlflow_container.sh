#!/bin/bash

# --------------------------------------------
# This script builds the MLflow container
#
# Author: Vivek Katial
# --------------------------------------------

set -e

# Function to check for AWS directory
check_aws_directory() {
    if [ -d .aws/ ]; then
        echo "[INFO] AWS directory is present."
    else
        echo "[ERROR] AWS directory is not present. Exiting."
        exit 1
    fi
}

# Function to check for AWS credentials
check_aws_credentials() {
    if [ ! -e .aws/credentials ]; then
        echo "[ERROR] AWS credentials not found. Please ensure they are transferred."
        echo "Hint: Try using SCP: 'scp -i ~/.ssh/<VM_PEM_KEY.pem> .aws/ ubuntu@<VM_URI>:ez-experimentr/'"
        exit 1
    else
        echo "[INFO] AWS credentials found."
    fi
}

# Function to check for environment file
check_env_file() {
    if [ -e ./env.list ]; then
        echo "[INFO] Environment file is present."
    else
        echo "[ERROR] Environment file is not present. Exiting."
        exit 1
    fi
}

# Function to build the container
build_container() {
    echo "[INFO] Starting to build the MLflow container..."

    if [ "$1" = "local" ]; then
        echo "[INFO] Performing a Local Build."
        docker build -f Dockerfile-mlflow-local -t ez-experimentr/local-mlflow .
    else
        echo "[INFO] Performing a Database Build."
        docker build -f Dockerfile-mlflow -t ez-experimentr/mlflow .
    fi

    echo "[INFO] MLflow container build completed."
}

# Main script execution
echo "[INFO] Initiating the MLflow container build script..."

# Perform checks
check_aws_directory
check_aws_credentials
check_env_file

# Build container
build_container $1
