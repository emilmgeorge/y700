#!/bin/bash

DIR_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
SUBSYSTEM=$(cat /proc/asound/card0/codec#0 | grep "Subsystem Id" | cut -d' ' -f3)
SUPPORTED=$(echo "0x17aa3826 0x17aa3827 0x17aa3829")
# Subsystems:
# 0x17aa3826 - Y700 15ISK http://www.alsa-project.org/db/?f=76d4653f8c546f5d0582f078e5e887929864efff
# 0x17aa3827 - Y700 15ISK http://www.alsa-project.org/db/?f=64daaaa8fa4f02bb488f087c55830e2c9d550396
# 0x17aa3829 - Y700 17ISK http://www.alsa-project.org/db/?f=98cb92ddb7432ff3418c0e839434d7e7e57209f5

if  [[ $1 = "--uninstall" ]]; then
	sudo rm /etc/modprobe.d/subwoofer.conf
	sudo rm /lib/firmware/subwoofer_patch.fw
	echo "	Removed file: /lib/firmware/subwoofer_patch.fw";
	echo "	Removed file: /etc/modprobe.d/subwoofer.conf";
	echo "SUCCESS! Reboot the system for changes to take effect.";
else
	if echo $SUPPORTED | grep -w $SUBSYSTEM > /dev/null; then
		echo "Codec Subsystem Id:" $SUBSYSTEM;
		echo "This will disable any module patches applied to snd_hda_intel (eg. hda-jack-retask fixes). Uninstalling this patch will re-enable them.";
		sudo cp "$DIR_PATH/subwoofer_patch.fw" /lib/firmware/;
		sudo sed  -i "s/SUBSYSTEM/$SUBSYSTEM/g" /lib/firmware/subwoofer_patch.fw;
		sudo chmod 0644 /lib/firmware/subwoofer_patch.fw;
		echo "	Added file: /lib/firmware/subwoofer_patch.fw";
		sudo cp "$DIR_PATH/subwoofer.conf" /etc/modprobe.d/;
		sudo chmod 0644 /etc/modprobe.d/subwoofer.conf;
		echo "	Added file: /etc/modprobe.d/subwoofer.conf";
		echo "SUCCESS! Reboot the system for changes to take effect.";
	else
		echo "Unsupported Codec Subsystem Id:" $SUBSYSTEM;
	fi
fi
