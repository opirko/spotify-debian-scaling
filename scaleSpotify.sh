#!/bin/bash
# this script scales spotify

#SPOTCONF_PATH="/usr/share/applications/spotify.desktop"
SPOTCONF_PATH="./spotify.desktop"
SPOT_SCALE="2"

echo "Following string is located in spotify config path:"
sudo grep 'spotify %U' ${SPOTCONF_PATH}
echo "This will be replaced with  spotify --force-device-scale-factor=${SPOT_SCALE} %U"
read -p "Is that ok? Type y or Y for confirmation." -n 1 -r
echo    # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	sudo sed -i "s/spotify %U/spotify --force-device-scale-factor=${SPOT_SCALE} %U/" ${SPOTCONF_PATH}
	echo "Operation executed."
fi
