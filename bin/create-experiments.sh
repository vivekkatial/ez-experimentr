#!/bin/bash

# Make sure
cd /data/cephfs/punim1074/

# Take repository
git_user="%%GIT_URL%%"

# Clone Repo from GIT
git clone $url 

# List files in cluster
ls

# Remove 
rm -rf $repo

ls

pwd

exit
