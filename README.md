# Phylogenetic analyses for southern appalachian arthropod phylogeography work

## Tasks
1. Identify partitions & models
    1. Install PartitionFinder 2 and dependencies [http://www.robertlanfear.com/partitionfinder/](http://www.robertlanfear.com/partitionfinder/)
    2. Convert from FASTA to phylip format
        + Uses R package ape
    3. Create configuration files .cfg
        + Information needed (that will vary by data set)
            1. Name of alignment file
            2. Data blocks (locations of genes and codons)
            For coding data:
            ```
            ## DATA BLOCKS ##
            [data_blocks]
            COI_pos1 = 2-762\3;
            COI_pos2 = 3-762\3;
            COI_pos3 = 1-762\3;
            COII_pos1 = 763-1125\3;
            COII_pos2 = 764-1125\3;
            COII_pos3 = 765-1125\3;
            ```
            For non-coding data:
            ```
            ## DATA BLOCKS ##
            [data_blocks]
            16S = 1-1174;
            CP50 = 1175-1656;
            CP63 = 1657-2230;
            CP78 = 2231-2686;
            ```
        + Create configuration template
        + Extract the two pieces of information and build the partition_finder.cfg file
        + Create a folder in partition_finder that has the config file and the phylip file
    4. Create bash script to run PartitionFinder for each data set (should be callable via `python <path-to-PartitionFinder.py> <path-to-folder-with-data>`)
2. Infer trees
    1. ...