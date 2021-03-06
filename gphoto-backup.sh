#!/usr/bin/env bash

# IMPORTANT:
# Run the install-little-backup-box.sh script first
# to install the required packages and configure the system.

# Specify a storage device and its mount point
HOME_DIR="/home/pi"

# Set the ACT LED to heartbeat
sudo sh -c "echo heartbeat > /sys/class/leds/led0/trigger"

# Wait for camera
DEVICE=$(gphoto2 --auto-detect | grep usb | cut -b 36-42 | sed 's/,/\//')
while [ -z ${DEVICE} ]
	do
	sleep 1
	DEVICE=$(gphoto2 --auto-detect | grep usb | cut -b 36-42 | sed 's/,/\//')
done

# Obtain camera model
# Create the target directory with the camera model as its name
CAMERA=$(gphoto2 --summary | grep "Model" | cut -d: -f2 | tr -d '[:space:]')
STORAGE_MOUNT_POINT="$HOME_DIR/$CAMERA"

# Set the ACT LED to blink at 500ms to indicate that the camera has been detected
sudo sh -c "echo 500 > /sys/class/leds/led0/delay_on"

# Switch to STORAGE_MOUNT_POINT and transfer files from the camera
# Rename the transferred files using the YYYYMMDD-HHMMSS format
cd $STORAGE_MOUNT_POINT
gphoto2 --get-all-files --skip-existing --filename=%Y%m%d-%H%M%S.%C
# Turn off the ACT LED to indicate that the backup is completed
sudo sh -c "echo 0 > /sys/class/leds/led0/brightness"

# Shutdown
shutdown -h now 
