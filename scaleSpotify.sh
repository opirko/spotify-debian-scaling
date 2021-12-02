#!/bin/bash
# this script scales spotify, customize config file path and scaling factor below.

#SPOTCONF_PATH="/usr/share/applications/spotify.desktop"
SPOTCONF_PATH="./spotify.desktop"
SPOT_SCALE="2"

SEARCH_STRING="spotify %U"
GREPOUT=`sudo grep "${SEARCH_STRING}" ${SPOTCONF_PATH}`
if [ -z "$GREPOUT" ]
then
	echo "String ${SEARCH_STRING} wasn't found in the given file."
	SEARCH_STRING="spotify --force-device-scale-factor=. %U" 
	GREPOUT=`sudo grep "${SEARCH_STRING}" ${SPOTCONF_PATH}`
	if [ -z "$GREPOUT" ]
	then
		echo "String ${SEARCH_STRING} wasn't found in the given file, terminating."
		exit 1
	fi
fi
# string in some form was found
echo "String ${SEARCH_STRING} was found in the given file."
echo "This will be replaced with spotify --force-device-scale-factor=${SPOT_SCALE} %U"
read -p "Is that ok? Type y or Y for confirmation." -n 1 -r
echo    # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	sudo sed -i "s/${SEARCH_STRING}$/spotify --force-device-scale-factor=${SPOT_SCALE} %U/" ${SPOTCONF_PATH}
	echo "Operation executed."
	exit 0
else
	echo "Operation not executed."
	exit 0
fi
