#!/bin/bash 

# This script requires the imagemagick package to be installed

FILELIST=$1   # Input file containing a list of PNG filenames
ALIAS=$2      # Alias of the output PNG files
NCOL=$3       # Number of columns
NROW=$4       # Number of rows

if [ -z $FILELIST ]
then
   echo "Usage: $0  FILELIST  [ ALIAS ]  [ NCOL ] [ NROW ]"
   exit
fi
NDAT=$(cat $FILELIST| wc -l)

if [ -z $ALIAS ]
then
   ALIAS="image_pasted"
fi
if [ -z $NCOL ]
then
   NCOL=3
fi
if [ -z $NROW ]
then
   if [ $NDAT -le $NCOL ]
   then
      NROW=1
   else
      let "NROW = $NDAT / $NCOL  "
   fi
fi

OFF_R="0"   # Pixel cropping at L, R, U or D  borders
OFF_L="0"
OFF_U="0"
OFF_D="0"

echo "paste_png.sh running with"
echo "FILELIST=$FILELIST"
echo "NDAT=$NDAT"
echo "ALIAS=$ALIAS"
echo "NCOL=$NCOL"
echo "NROW=$NROW"

WORKDIR=$PWD
PAGE=1

NROW_counter=0
# Loop over PNG files
for ((i=1; i<= NDAT; i+=NCOL))
do
  let " k = $i + $NCOL -1 "
  if [ "$k" -gt "$NDAT" ]
  then 
     j="$NDAT"
  else
     j=$k
  fi
  TEMP=$(sed -n "${i},${j}p" $1 | sed 's/.png//g')
  k=0
  for complex in $(echo $TEMP)
  do
    convert  -scale 66% -pointsize 25 -crop +${OFF_L}+0 -crop -${OFF_L}+0 -crop +0+${OFF_U} -crop +0-${OFF_D}  ${complex}.png tmp.png 
    if [ -e temp_row.png ] 
    then 
      convert temp_row.png tmp.png  +append temp.png; mv temp.png temp_row.png
      rm -f  tmp.png 
    else
     mv tmp.png temp_row.png
    fi
  done 
  let "NROW_counter = $NROW_counter + 1"
  if [ "$NROW_counter"  -lt 10 ]
  then
      txt="00${NROW_counter}"
  elif [ "$NROW_counter"  -lt 100 ]
  then
      txt="0${NROW_counter}"
  else
      txt="${NROW_counter}"
  fi
  mv temp_row.png tmp_row_${txt}.png 
  if [ "$NROW_counter" -eq "$NROW" ]
  then 
     convert tmp_row_*.png -append ${ALIAS}_${PAGE}.png
     let " PAGE = $PAGE + 1 "
     let " NROW_counter = 0 "
     rm -f tmp_row_*.png 
  fi 
done
if [ "$NROW_counter" -lt "$NROW" ]
then    
     convert tmp_row_*.png -append ${ALIAS}_${PAGE}.png
     rm -f tmp_row_*.png 
fi


