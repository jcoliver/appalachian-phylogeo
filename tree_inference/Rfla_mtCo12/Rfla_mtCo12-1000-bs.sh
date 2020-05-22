#!/bin/bash

# Only need to change these five variables
NUMBS="1000"
DATASET="Rfla_mtCo12"
MODEL="GTRGAMMA"
OUTGROUP="R_virgi"
 # Absolute path for writing output files, because RAxML is dumb
ABSPATH="~/Documents/Science/Papers/Appalachian-Phylo/appalachian-phylogeo/tree_inference"

ANALYSISNAME="$NUMBS bootstraps on $DATASET data"
DATAPATH="$DATASET"
SEQFILE="${DATASET}.phy"
OUTDIR="${ABSPATH}/${DATASET}/bs-$NUMBS"
PREFIX="$DATAPATH-$NUMBS-bs"
PARTSFILE="${DATASET}.parts"
RAXMLPATH="raxmlHPC-PTHREADS"
SEED=202005221208

echo "===   START $ANALYSISNAME   ==="

# Check to make sure output directory exists
[ ! -d "bs-$NUMBS" ] && eval mkdir "bs-$NUMBS"

# Remove previous RAxML output files
eval rm "${NUMBS}-bs/RAxML_*"

# Unclear why `eval` is needed, but script won't work without it
eval "$RAXMLPATH" -f a -p $SEED -x $SEED -s "$SEQFILE" -w "$OUTDIR" -n "$PREFIX" -m "$MODEL" -"#$NUMBS" -T 6 -o "$OUTGROUP" -q "$PARTSFILE"

echo "===   END $ANALYSISNAME   ==="
