#!/bin/bash

# Make sure
cd /data/cephfs/punim1074/

# Take repository
repo="ez-experimentr"
url="https://github.com/vivekkatial/$repo"

# Clone Repo from GIT
git clone $url 

# List files in cluster
ls

# Remove 
rm -rf $repo

ls

pwd
