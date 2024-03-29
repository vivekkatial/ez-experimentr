#!/bin/bash

# --------------------------------------------
# This script Deploys the MLflow container
#
# Author: Vivek Katial
# --------------------------------------------

export PORT=5000
export PORT_LOCAL=3000

if [ "$1" = "local" ]; then 
    echo "Local Build"
    docker run -d -p $PORT_LOCAL:3000 --env-file ./env.list ez-experimentr/local-mlflow && \
    echo "Mlflow Tracking Server running on http://localhost:$PORT_LOCAL"
else
    echo "DB BACKEND INSTANCE"
    docker run -d -p $PORT:5000 --env-file ./env.list ez-experimentr/mlflow && \
    echo "Mlflow Tracking Server running on http://localhost:$PORT"
fi
