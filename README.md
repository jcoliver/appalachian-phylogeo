# Phylogenetic analyses for southern appalachian arthropod phylogeography work

## Tasks
1. Identify partitions & models
    1. Install PartitionFinder 2 and dependencies [http://www.robertlanfear.com/partitionfinder/](http://www.robertlanfear.com/partitionfinder/)
        + Requires use of Python version 2.7.x, and additional packages:
            + numpy
                + Ultimately had to uninstall a few old versions of this via
                `python2 -m pip uninstall numpy`
            + pandas
            + pytables `python2 -m pip install tables==3.5.2`
            + pyparsing
            + scipy
            + sklearn
            + All except pytables installed via `python2 -m pip install <package-name>`
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
        + RAxML will only allow a single type of rate heterogeneity for an analysis to be applied across all partitions. That is, they all need to be either GTR, GTR+G, or GTR+G+I. So will need to have separate partitionfinder runs for each of those three, then compare AICc values.
        + Create a folder in partition_finder that has the config file and the phylip file
    4. Make sure RAxML is installed so PartitionFinder can use it to evaluate models of evolution (and restrict evaluation to options available in RAxML)
    5. Create bash script to run PartitionFinder for each data set: `python2 <path-to-PartitionFinder.py> --raxml --force-restart <path-to-folder-with-data>`
        + run-partitionfinder.sh
    6. Compare the best scheme from each of the three models (GTR vs. GTR+G vs. GTR+G+I) for each data set. Save the best_scheme.txt file to the appropriate folder in partition_finder folder. e.g. best scheme for the Cpun_mtCo12 data goes into partition_finder/Cpun_mtCo12
        + compare-schemes.R
2. Infer trees
    0. See tree_inference/host-100-bs.sh for example of how to do this.
    1. Set up folders in tree_inference for each data set with the .phy files from the data folder
        + setup-tree-inference.R
    2. Create a .parts file for each data set. Current implementation is to do this manually, copy-pasting from partition_finder/<DATASET>/best_scheme_overall.txt into tree_inference/<DATASET>/<DATASET>.parts
    3. Create a script for running RAxML bootstraps. Also a manual process.
        + On the UA HPC, the version of RAxML is raxmlHPC-PTHREADS-AVX2 (and has to be loaded in via `module load raxml`)