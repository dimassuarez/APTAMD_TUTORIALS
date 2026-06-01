#!/bin/bash

# Input file: CSV file with Pubchem CID and SMILES codes
# Execution of this script requires the openbabel and imagemagick packages to be installed 
CID_SMILES_CSV=$1
i=0
for code in $(cat $CID_SMILES_CSV | grep -v '#' | awk -F ',' '{print $2}')
do
  let "i=$i+1"
  obabel -:"$code" -O tmp.svg 
  convert -density 600  -background none -resize 512x512 tmp.svg tmp.png
  mv tmp.png mol_${i}.png
done

   
