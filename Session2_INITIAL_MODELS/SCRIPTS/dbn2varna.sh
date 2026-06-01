#!/bin/bash

# Script for creating VARNA 2D plot from dbn files
VARNA_JAR="/usr/local/bin/VARNAv3-93.jar "

NARG="$#"
if [ $NARG -eq 0 ]
then
	echo "Usage: dbn2varna file1.dbn  file2.dbn ...."
	exit
fi

ARG=$@
for file in $ARG
do
	prefix=${file/.*}
	dbn=${prefix}.dbn
	png=${prefix}.png 
	if [ -e $dbn ]
	then
		echo "Creating $png from $dbn using VARNA"
		java -cp ${VARNA_JAR} fr.orsay.lri.varna.applications.VARNAcmd \
	  -resolution 4.0 \
	  -bpstyle lw \
	  -spaceBetweenBases 1.2 \
	  -algorithm naview \
	  -i ${dbn} \
	  -o ${png} 
	fi
done





