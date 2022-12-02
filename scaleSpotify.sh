#!/bin/bash
# This script scales spotify UI - works with ints and floats.
# Customize config file path and scaling factor below.

# Config
SPOT_SCALE="2"
SEARCH_STRING_ORIG="spotify %U"

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Colour

# find the files, typically two
readarray -d '' FILEARRAY < <(find /usr/share/ -name "spotify.desktop" -print0 2>/dev/null)

for i in "${FILEARRAY[@]}"
do
	# reset search string to the default one
	SEARCH_STRING=$SEARCH_STRING_ORIG
	echo -e "${YELLOW}Found file $i to change.${NC}"
	GREPOUT=`sudo grep "${SEARCH_STRING}" ${i}`
	if [ -z "$GREPOUT" ]
	then
		echo -e "String \"${CYAN}${SEARCH_STRING}${NC}\" wasn't found in the given file."
		SEARCH_STRING="spotify --force-device-scale-factor=[+-]?([0-9]*[.])?[0-9]+ %U" 
		GREPOUT=`sudo grep -E "${SEARCH_STRING}" ${i}`
		if [ -z "$GREPOUT" ]
		then
			echo -e "String \"${CYAN}${SEARCH_STRING}${NC}\" wasn't found in the given file, terminating."
			continue
		fi
	fi
	# string in some form was found
	echo -e "String \"${CYAN}${SEARCH_STRING}${NC}\" was found in the given file."
	echo "This will be replaced with spotify --force-device-scale-factor=${SPOT_SCALE} %U"
	read -p "Is that ok? Type y or Y for confirmation." -n 1 -r
	echo    # move to a new line
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		sudo sed -E -i "s/${SEARCH_STRING}$/spotify --force-device-scale-factor=${SPOT_SCALE} %U/" ${i}
		echo -e "${GREEN}Operation executed.${NC}"
		continue
	else
		echo -e "${YELLOW}Operation not executed.${NC}"
		continue
	fi
done
