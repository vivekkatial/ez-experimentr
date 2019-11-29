# Notes Sublime

A discussion on how to set up R with Singularity for reproducible research.

## R 

R is an open-source programming language designed specifically for statistical computing, data science and scientifc research. Despite of this, R now has many usecases; ranging from developing web-applications to running within production ML pipelines.

Within the research community there is an increasing urgency on producing results/code which can be reproduced and validated by external parties. Despite many researchers now using tools such as Github to version and share code, as the technologies used by researches expand the ability to reproduce entire environments is becoming increasingly more difficult and more complex.

Containers are a tool that enable us to define this complex environments using simple, versionable text files.

## Singularity 

Singularity is a *container* technology. Essentially a container is a curated collection of resource requirements to run an application. 

Contianers are specified by a simple text file which is easily documented and version-controlled through tools like Git. Containers allow for the reproducibility of entire environments and also make applications portable. Container technologies like Docker are widely used in industry, however often in research environments (where arguably reproducibility is most important) users don't have root access to the computing resources they use (particularly in HPC).

This provides the motivation for Singularity. Singularity is a container-technology designed for use in HPC environments. Singularity will virtualise the minimum amount of computing resources enabling applications fullaccess to fast hardware resources.

