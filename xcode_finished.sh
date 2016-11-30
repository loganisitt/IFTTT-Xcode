#!/bin/bash

function displaytime {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  [[ $D > 0 ]] && printf '%d days ' $D
  [[ $H > 0 ]] && printf '%d hours ' $H
  [[ $M > 0 ]] && printf '%d minutes ' $M
  [[ $D > 0 || $H > 0 || $M > 0 ]] && printf 'and '
  printf '%d seconds\n' $S
}

KEY=AB3dEFGH9Jkl3NOP4_StU # Replace with your Maker key

START=$(cat ~/Documents/Scripts/build_start_time)
END=$(date +%s)
DURATION=`expr $END - $START`
rm ~/Documents/Scripts/build_start_time

PROJECT=$(echo $XcodeProject | sed -e "s/".xcodeproj"/""/g")
ALERT=$IDEAlertMessage
BUILD_TIME=`echo $(displaytime $DURATION)`

IDLE=$((`ioreg -c IOHIDSystem | sed -e '/HIDIdleTime/ !{ d' -e 't' -e '}' -e 's/.* = //g' -e 'q'` / 1000000000))

if [ "$IDLE" -ge 30 ]; then
  curl -X POST  -H "Content-Type: application/json" -d "{\"value1\":\"$PROJECT\", \"value2\":\"$ALERT\", \"value3\":\"$BUILD_TIME\"}" https://maker.ifttt.com/trigger/Xcode/with/key/$KEY
fi
