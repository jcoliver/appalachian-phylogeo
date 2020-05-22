#!/bin/bash

# Only need to change these three variables
NUMBS="100"
ORG="Host"
LOCUS="Co1Co2"

# Will ultimately want to open the RAxML_bipartitions file; it has the ML tree
# with bootstrap scores on it

ANALYSISNAME="$NUMBS bootstraps on $ORG data"
ORGLC=$(echo "$ORG" | tr '[:upper:]' '[:lower:]')
DATAPATH="../data/$ORGLC"
SEQFILE="$DATAPATH/${ORG}_${LOCUS}_n97_Outgr.phy"
OUTDIR="~/Documents/Papers/Garrick/tree-inference/output/$ORGLC/bs-$NUMBS"
PREFIX="$ORGLC-$NUMBS-bs"
PARTSFILE="../data/$ORGLC/$ORG.parts"

RAXMLPATH="~/Executables/standard-RAxML-PTHREADS/raxmlHPC-PTHREADS"
SEED=201612161011

echo "===   START $ANALYSISNAME   ==="

# Unclear why `eval` is needed, but script won't work without it
eval "$RAXMLPATH" -f a -p $SEED -x $SEED -s "$SEQFILE" -w "$OUTDIR" -n "$PREFIX" -m GTRGAMMAI -"#$NUMBS" -T 6 -o M_darwin -q "$PARTSFILE"

echo "===   END $ANALYSISNAME   ==="
