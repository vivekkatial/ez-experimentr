#!/bin/bash

# Make sure
cd /data/cephfs/punim1074/

# Take repository
git_url="%%GIT_URL%%"
repo="%%REPO%%"

# Clone Repo from GIT
git clone $git_url 

# List files in cluster
ls

# Remove 
rm -rf $repo

pwd

exit
