#!/bin/bash
# Author: Logan Isitt

date=
project=

function displaytime {
  local T=$1
  local M=$((T/60))
  local S=$((T%60))
  [[ $M > 0 ]] && printf '%d minutes' $M
  [[ $M > 0 ]] && [[ $S > 0 ]] && printf ' and '
  [[ $S > 0 ]] && printf '%d seconds' $S
}

function usage {
    echo "usage: $(basename "$0") [-p project] [-d date] [-h]"
    echo "date format: YYYY-mm-dd"
}

while [ "$1" != "" ]; do
    case $1 in
        -p | --project )        shift
                                project=$1
                                ;;
        -d | --date )           shift
                                date=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

read parY parM parD rest<<< ${date//[-: ]/ }

while IFS="," read a p d t;
do
  if [ "$date" != "" ]; then
    read logY logM logD rest<<< ${d//[-: ]/ }
    if [ "$logY" != "$parY" ] || [ "$logM" != "$parM" ] || [ "$logD" != "$parD" ]; then
      continue
    fi
  fi
  if [ "$project" != "" ]; then
    if [ "$project" != $p ]; then
      continue
    fi
  fi
  sum=$((sum + t))
  count=$((count + 1))
  if [ "$longest" == "" ] || [ $t -gt $longest ]; then
    longest=$((t))
  fi
done < buildlog.csv

echo "Total:   " $(displaytime $sum)
echo "Average: " $(displaytime $((sum / count)))
echo "Longest: " $(displaytime $longest)
