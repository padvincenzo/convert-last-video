#!/bin/bash

#
# Convert last video
#
# Convert last edited (or created) mkv video to an mp4 video, using ffmpeg. I am
# using this script to atutomate the conversion of recordings generated by OBS.
#
# To use it, put the script in ~/Video/OBS (or in the folder that will contains
# your OBS recordings) and, when you stop a recording, just type
#
#                 ~/Video/OBS/convert_last.sh
#
# in the terminal. In my personal configuration, this script save up to 75% of disk usage.
#

#
# Author: Vincenzo Padula
# GitHub: https://github.com/padvincenzo/convert-last-video
#

# Get the filename (without extension) of the last modified mkv video
LAST_VIDEO=$(ls -t | grep mkv | head -1 | awk -F . '{print $1}')

# No videos found, exiting
if [ -z "${LAST_VIDEO}" ]; then
	echo "Hi $(whoami), it seems that there's not any mkv video to be converted. Bye"
	exit 1
fi

# Starting to convert the video
echo "Hi $(whoami), I'll now proceed to convert your ${LAST_VIDEO}.mkv to an mp4 video..."
ffmpeg -hide_banner -loglevel 0 -stats -i ${LAST_VIDEO}.mkv ${LAST_VIDEO}.mp4

# Conversion failed, exiting
if [ $? -ne 0 ]; then
	echo "Sorry $(whoami), something went wrong with the conversion."
	exit 2
fi

# Conversion went well, exiting
echo "Thanks for your patience! ${LAST_VIDEO}.mp4 is now ready."
exit 0
