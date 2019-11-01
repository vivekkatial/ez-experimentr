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

# Remove tmp folder from previous run
rm -rf tmp

# Put helpers in temp location
mkdir tmp
mkdir tmp/bin/
mkdir tmp/config/

mv parse_yaml.sh tmp/bin/
mv experiment_config.yml tmp/config/

# include parse_yaml function   
. tmp/bin/parse_yaml.sh

# read experiment configuration
eval $(parse_yaml tmp/config/experiment_config.yml)

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
	echo "Could not locate SingularityFile.def Singularity definition file"	
else
	echo "Singularity definition file found, checking for image..."
fi

# Checking if Singularity container image present
if [ ! -e portable-image.img ] ; then
	echo "Could not locate container image: 'portable-image.img' pulling container image from $experiment_singularity_image_uri"
	scp -i ~/.ssh/nectarkey-test.pem $experiment_singularity_image_uri . -o StrictHostKeyChecking=no
else
	echo "Singularity container image found, executing container..."
fi


# Checking if SLURM script for building experiments present
if [ ! -e bin/build_experiment_files.slurm ] ; then
	echo "Could not locate build_experiment_files.slurm shell script"	
else
	echo "Building experiments"
	sbatch bin/build_experiment_files.slurm
fi



exit
