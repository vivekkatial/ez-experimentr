#!/bin/bash

# --------------------------------------------
# This script is Deploys the mlflow container
#
# Author: Vivek Katial
# --------------------------------------------

export PORT=5000

docker run -d -p $PORT:5000 -e DISABLE_AUTH=true ez-experimentr/mlflow && \
echo "Mlflow Tracking Server running on http://localhost:$PORT"