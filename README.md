# Phylogenetic analyses for southern appalachian arthropod phylogeography work

## Tasks
1. Identify partitions & models
    1. Install PartitionFinder 2 and dependencies [http://www.robertlanfear.com/partitionfinder/](http://www.robertlanfear.com/partitionfinder/)
    2. Convert from FASTA to phylip format
        + fasta-to-phylip.R
        + Uses R package ape
    3. Create configuration files .cfg
        + create-partition-config.R
        + Information needed (that will vary by data set)
            1. Name of alignment file
            2. Data blocks (locations of genes and codons)
        + Create configuration template
        + Extract the two pieces of information and build the partition_finder.cfg file
        + Create a folder in partition_finder that has the config file and the phylip file
    4. Create bash script to run PartitionFinder for each data set (should be callable via `python <path-to-PartitionFinder.py> <path-to-folder-with-data>`)
        + find-partitions.sh
2. Infer trees
    1. ...