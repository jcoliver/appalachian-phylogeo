# Phylogenetic analyses for southern appalachian arthropod phylogeography work

## Tasks
1. Identify partitions & models
    1. Install PartitionFinder 2 and dependencies [http://www.robertlanfear.com/partitionfinder/](http://www.robertlanfear.com/partitionfinder/)
    2. Convert from FASTA to phylip format
        + Uses R package ape
    3. Create configuration files .cfg
    4. Create bash script to run PartitionFinder for each data set (should be callable via `python <path-to-PartitionFinder.py> <path-to-folder-with-data>`)
2. Infer trees
    1. ...