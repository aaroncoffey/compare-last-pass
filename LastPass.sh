#!/bin/bash

# Author: Aaron Coffey
# Date: Late 2012
# Name: LastPass.sh
# Purpose: To take images from a given folder in pairs, compare them, and
# remove the images that are too different from each other.

# Intended Implementation:
# Use ImageMagick to compare pic1 to pic2, if difference >= 5% remove pic2, compare
# pic1 to pic3 if different discard pic3 etc. Ensure script will only remove at most
# up to 5 images in a row. In this example, the script would then start with pic7
# and compare it to pic8. This works because most of the pics are good. This would
# not work if most of the pics were bad.

# initial path to pictures, this will be determined based on the date function
PICTURES=~/path/to/pics/*
allowedDIFF=5%
# discardPath will be used to move pictures that need to be removed from the main folder.
discardPATH=~/path/to/pics/discarded/
# these variables are obviously not set correctly. If I only needed to grab each image in turn
# I would use the already implemented $f
pic1=~/path/to/pics/firstImageInFolder.jpg
pic2=~/path/to/pics/secondImageInFolder.jpg

# load pics
for f in $PICTURES
do
    # compare pics: uses imageMagick to return a % difference between two photos
    DIFFERENCE = convert $pic1 $pic2 -compose difference -composite -colorspace Gray -format '%[fx:mean*100]' info:

    # check and remove if malformed: this does not work as an if statement
    # if an malformed pic was found it should continue looping, up to 5 times.
    if [ $DIFFERENCE -ge $allowedDIFF ]; then
        mv $pic2 $discardPATH
        # increment pic2: this is not valid as written :(
        $pic2 = pic2 + 1
    fi

    # pic1 should now be incremented to the next picture in the folder
    # this must take into account that the next image may have been removed
    $pic1 = pic1 + 1
    # pic2 is just $pic1 with 20 seconds added to the filename.

done
