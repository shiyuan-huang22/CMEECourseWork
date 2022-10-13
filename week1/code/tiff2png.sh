#!/bin/bash
# Author: Shiyuan sh422@ic.ac.uk
# Script: tiff2png.sh
# Description: Convert tiff to png
# Arguements: none
# Date: Oct.2022


if [ -z "$1" ] ; then #Check if user entered a file  
	echo "Please enter an image name!"
else
	if [ -f "$1" ] ; then #If user enter a file and it exists
    
	    if [[ $1 == *.tif ]] ; then #Check if the entered file is an image	
		
			echo "converting $1"
			convert "$1" "${1%tif}png" 
			echo "Done!"
		else
			echo "Input is not a tiff image"
		fi
	else 
        echo "File does not exist"
    fi

fi