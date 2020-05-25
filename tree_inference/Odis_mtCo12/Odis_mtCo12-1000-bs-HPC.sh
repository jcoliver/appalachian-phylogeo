#!/bin/bash

# Only need to change these five variables
NUMBS="1000"
DATASET="Odis_mtCo12"
MODEL="GTRCAT"
OUTGROUP="O_striat"
#ABSPATH="~/Documents/Science/Papers/Appalachian-Phylo/appalachian-phylogeo/tree_inference"

ANALYSISNAME="$NUMBS bootstraps on $DATASET data"
#DATAPATH="$DATASET"
SEQFILE="${DATASET}.phy"
#OUTDIR="${ABSPATH}/${DATASET}/bs-$NUMBS"
PREFIX="${DATASET}-$NUMBS-bs"
PARTSFILE="${DATASET}.parts"
RAXMLPATH="raxmlHPC-PTHREADS-AVX2"
SEED=202005221208

echo "===   START $ANALYSISNAME   ==="

# Check to make sure output directory exists
# [ ! -d "bs-$NUMBS" ] && eval mkdir "bs-$NUMBS"

# Remove previous RAxML output files
eval rm "RAxML_*.${PREFIX}"

# Unclear why `eval` is needed, but script won't work without it
eval "$RAXMLPATH" -f a -T 8 -p $SEED -x $SEED -s "$SEQFILE" -n "$PREFIX" -m "$MODEL" -"#$NUMBS" -T 6 -o "$OUTGROUP" -q "$PARTSFILE"

echo "===   END $ANALYSISNAME   ==="
