#!/bin/bash

# --------------------------------------------
# This script implements the make functionality
# of the ez-experimentr. It will produce all
# configurations of the experiments defined in
# the parameters_template.yml file of your 
# experiment repository.
#
# The script requires you to have configured
# your Github account on the cluster
#
# Please ensure you have set up SSH-free login
# with a public key
#
# Author: Vivek Katial
# --------------------------------------------

# Set up fail tags

set -e

# Remove tmp folder from previous run
rm -rf tmp

# Put helpers in temp location
mkdir tmp
mkdir tmp/bin/
mkdir tmp/config/
mkdir tmp/credentials/

mv parse_yaml.sh tmp/bin/
mv experiment_config.yml tmp/config/
mv resource_access_credentials.yml tmp/credentials/

# include parse_yaml function   
. tmp/bin/parse_yaml.sh

# read experiment configuration
eval $(parse_yaml tmp/config/experiment_config.yml)

# read resource access configuration
eval $(parse_yaml tmp/credentials/resource_access_credentials.yml)

# Change directory to project URI
cd $experiment_cluster_uri

# Clone the experiments repository
if [ ! -d "$experiment_repository" ] ; then
    # If experiment repo not present then clone the repository
    git clone $experiment_github_url $experiment_repository
    cd $experiment_repository
else
    # If experiment repo already there then use most recent repo
    cd "$experiment_repository"
    git pull $experiment_github_url
fi

# Checking if SingularityFile script for building container present in repo
if [ ! -e SingularityFile.def ] ; then
    echo "ERROR: Could not locate SingularityFile.def Singularity definition file" 
else
    echo "Singularity definition file found, checking for image..."
fi

# Checking if Singularity container image present
echo "Pulling Singularity container image from $experiment_singularity_image_uri"

if scp -o StrictHostKeyChecking=no -i ~/.ssh/$credentials_mrc_container_key $experiment_singularity_image_uri .
then
    echo "Successfully downloaded Singularity container..."
else
    echo "ERROR: Cannot find Singularity container at the specified URI: $experiment_singularity_image_uri"
    echo "ERROR: Please ensure you have built the container file"
    echo "ERROR: Please execute 'singularity build <IMAGE_FILENAME> SingularityFile.def' on your VM"
    exit 0
fi


# Checking if SingularityFile script for building container present in repo
if [ ! -d ~/.aws ] ; then
    echo "ERROR: Could not locate AWS-CLI credentials, please upload into your home directory in the folder '.aws/'" 
else
    # Copying `S3 Object Storage` credentials into repository
    echo "Copying S3 Object Storage credentials into repository"
    cp -r ~/.aws .
fi

# Checking if SLURM script for building experiments present
if [ ! -e bin/build/build_experiment_files.slurm ] ; then
    echo "ERROR: Could not locate build_experiment_files.slurm shell script"   
else
    echo "Provisioning experiments"
    export OUTPUT_FILENAME="experiment-prep-job-$(date '+%d-%m-%Y')"
    echo "Results will be outputted to: $OUTPUT_FILENAME"
    sbatch --output=$OUTPUT_FILENAME bin/build/build_experiment_files.slurm
    squeue -u $experiment_cluster_username
fi

# Delete tmp folder
rm -rf tmp

exit
