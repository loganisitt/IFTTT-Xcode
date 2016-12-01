#!/bin/bash

function displaytime {
  local T=$1
  local M=$((T/60))
  local S=$((T%60))
  [[ $M > 0 ]] && printf '%d minutes' $M
  [[ $M > 0 ]] && [[ $S > 0 ]] && printf ' and '
  [[ $S > 0 ]] && printf '%d seconds' $S
}

# IFTTT Maker Key - Replace with your Maker key
KEY=AB3dEFGH9Jkl3NOP4_StU

# Get Project Name
PROJECT=$(echo $XcodeProject | sed -e "s/".xcodeproj"/""/g")

# Compute Build Time
START=$(cat `dirname $0`/$PROJECT-timestamp)
END=$(date +%s)
DURATION=`expr $END - $START`
BUILD_TIME=`echo $(displaytime $DURATION)`

# Maximum idle time allowed to supress notification
MAX_IDLE=30

# Get Idle Time
IDLE=$((`ioreg -c IOHIDSystem | sed -e '/HIDIdleTime/ !{ d' -e 't' -e '}' -e 's/.* = //g' -e 'q'` / 1000000000))

# Send notification if idle time is greater than max idle time
if [ $IDLE -ge $MAX_IDLE ]; then
  curl -X POST  -H "Content-Type: application/json" -d "{\"value1\":\"$PROJECT\", \"value2\":\"$IDEAlertMessage\", \"value3\":\"$BUILD_TIME\"}" https://maker.ifttt.com/trigger/Xcode/with/key/$KEY
fi

# Clean up
rm `dirname $0`/$PROJECT-timestamp
