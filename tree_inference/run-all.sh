#!/bin/bash

### Run all tree inference scripts

### ### indicates comment
### #PBS indicates PBS command

### Set the job name
#PBS -N appphylo

### Specify the PI group for this job
### List of PI groups available to each user can be found with "va" command
#PBS -W group_list=jcoliver

### Set the queue for this job as windfall or standard (adjust ### and #)
###PBS -q standard
#PBS -q windfall

### Set the number of cores and memory that will be used for this job
### select=1 is the node count, ncpus=4 are the cores in each node,
### mem=4gb is memory per node, pcmem=6gb is the memory per core - optional
#PBS -l select=1:ncpus=8:mem=12gb

### Specify "wallclock time", hhh:mm:ss. Required field
#PBS -l walltime=02:00:00

### cd: set directory for job execution, ~netid = home directory path
### executable command with trailing &. Do NOT assign more resources than the node has.
### Each iteration below will consume memory and cpu.

module load raxml

cd ~jcoliver/Documents/appalachian-phylogeo/tree_inference/Cpun_mtCo12
date
./Cpun_mtCo12-1000-bs-HPC.sh&
date
cd ~jcoliver/Documents/appalachian-phylogeo/tree_inference/Nameric_mt16S_tRNA-Val_12S
date
./Nameric_mt16S_tRNA-Val_12S-1000-bs-HPC.sh&
date
cd ~jcoliver/Documents/appalachian-phylogeo/tree_inference/Odis_mtCo12
date
./Odis_mtCo12-1000-bs-HPC.sh&
date
cd ~jcoliver/Documents/appalachian-phylogeo/tree_inference/Rfla_mtCo12
date
./Rfla_mtCo12-1000-bs-HPC.sh&
date
cd ~jcoliver/Documents/appalachian-phylogeo/tree_inference/Ssex_mtCo1
date
./Ssex_mtCo1-1000-bs-HPC.sh
date