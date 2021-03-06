#!/bin/bash
# Run partition finder for all data sets
# Jeffrey C. Oliver
# jcoliver@arizona.edu
# 2020-04-17

# location of partition finder python script
PFLOC="../partitionfinder-2.1.1/PartitionFinder.py"

# all the data folders (ones where we had partition data files)
FOLDERS=($(ls -d partition_finder/*/GTR*/))
# FOLDERS=($(ls paritition_finder/*_part_data.csv | sed 's/data\///g' | sed 's/_part_data.csv//g'))

# iterate over all folders and run partition finder
for folder in ${FOLDERS[@]}; do
  # echo $folder
  PYCMD="python2 $PFLOC --raxml --force-restart $folder"
  # echo $PYCMD
  eval $PYCMD
done
