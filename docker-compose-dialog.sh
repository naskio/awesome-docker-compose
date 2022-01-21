#!/bin/bash

# script to manage docker-compose stacks using dialog
# chmod +x ./docker-compose-dialog.sh

# get list of docker-compose stacks
#array1=("test_1.yml" "test_2.yml" "test3.yaml")
array1=()
while IFS=  read -r -d $'\n'; do
    array1+=("$REPLY")
done < <(find /home/ -regex '.*/docker-compose.ya?ml' -printf '%h\n' | sort -u)

# commands
array2=("resync" "restart" "up" "down")

# convert folders array to string
array1_string=""
for i in "${!array1[@]}"; do
    array1_string+="$((i + 1)) ${array1[$i]} off "
done
echo "$array1_string"

# convert commands array to string
array2_string=""
for i in "${!array2[@]}"; do
    array2_string+="$((i + 1)) ${array2[$i]} "
done
echo "$array2_string"

# usage: run_operation $folder $operation;
run_operation(){
  local folder="$1"
	shift
	local operation="$1"
  echo "- RUNNING COMMAND $operation ON $folder"
  case $operation in
    "resync") cd $folder && docker-compose down && git pull && docker-compose up -d;;
    "restart") cd $folder && docker-compose down && docker-compose up -d;;
    "up") cd $folder && docker-compose up -d;;
    "down") cd $folder && docker-compose down;;
    *) echo "Invalid option $folder with $operation.";;
  esac
}

# usage: run_operation_dry $folder $operation;
run_operation_dry(){
  local folder="$1"
	shift
	local operation="$1"
  echo "- RUNNING COMMAND $operation ON $folder"
  case $operation in
    "resync") echo "cd $folder && docker-compose down && git pull && docker-compose up -d";;
    "restart") echo "cd $folder && docker-compose down && docker-compose up -d";;
    "up") echo "cd $folder && docker-compose up -d";;
    "down") echo "cd $folder && docker-compose down";;
    *) echo "Invalid option $folder with $operation.";;
  esac
}

# prompt user for operation
TMPFILE=$(mktemp)
dialog --ok-label "NEXT" --cancel-label "QUIT" --menu "Choose the operation:" 0 0 0 $array2_string 2>$TMPFILE
OPERATION=$(cat $TMPFILE) # index
rm $TMPFILE

if [ $OPERATION ]; then
  # get operation string
  OPERATION=${array2[$((OPERATION - 1))]}
  # read folders
  TMPFILE=$(mktemp)
  dialog --ok-label "RUN" --cancel-label "QUIT" --checklist "Select folders:" 0 0 0 $array1_string 2>$TMPFILE
  FOLDERS=$(cat $TMPFILE) # indexes
  rm $TMPFILE
  # if empty, quit
  if [ -z $FOLDERS ]; then
    clear
    echo "No folders selected."
    exit
  fi
  # convert string to array of indexes
  FOLDERS=( "$FOLDERS" )
  # run operation on each folder
  if (( ${#FOLDERS[@]} != 0 )); then
    clear
    for i in $FOLDERS; do
      FOLDER=${array1[$((i - 1))]} # get folder string
#      run_operation_dry $FOLDER $OPERATION;
      run_operation $FOLDER $OPERATION;
    done
  else
    clear
    echo "No folders selected."
  fi
else
  clear
  echo "No operation selected."
fi
