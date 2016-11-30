#!/bin/bash

PROJECT=$(echo $XcodeProject | sed -e "s/".xcodeproj"/""/g")
echo $(date +%s) > `dirname $0`/$PROJECT-timestamp
