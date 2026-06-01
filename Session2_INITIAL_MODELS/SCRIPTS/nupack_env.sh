#!/bin/bash

echo "BASH wrapper script for loading nupack conda environment"
echo "==========================================================="

if [[ "$CONDA_DEFAULT_ENV" == "nupack" ]]; then
    echo "Environment 'nupack' is active."
    exit 
fi

if [[ "$CONDA_DEFAULT_ENV" == "base" ]]; then
    echo "Environment 'base' is already active."
else 
    echo "Loading base conda environment"
    source /opt/apps/AL8/miniconda3/bin/activate
fi
# Activating nupack
echo "Activating base conda environment"
conda activate nupack 
conda env list
export PS1="($CONDA_DEFAULT_ENV)\u@\h \W]\$ "
# Opening a bash environment
exec bash 
