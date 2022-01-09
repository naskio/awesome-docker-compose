#!/bin/bash
# script to manage docker-compose stacks using CLI
# chmod +x ./docker-compose-cli.sh

# get all folders which has docker-compose.y(a)ml file in it
#find /home/ -regex '.*/docker-compose.ya?ml' -printf '%h\n' | sort -u

array=()
while IFS=  read -r -d $'\n'; do
    array+=("$REPLY")
done < <(find /home/ -regex '.*/docker-compose.ya?ml' -printf '%h\n' | sort -u)

calculate () {
  PS3="Select the operation: "
  select operation in up down restart resync Quit; do
    case $operation in
        "resync") cd $1 && docker-compose down && git pull && docker-compose up -d && cd /home/;break;;
        "restart") cd $1 && docker-compose down && docker-compose up -d && cd /home/;break;;
        "up") cd $1 && docker-compose up -d && cd /home/;break;;
        "down") cd $1 && docker-compose down && cd /home/;break;;
        "Quit") break;;
#        *) echo "Invalid option $REPLY. Try another one.";continue;;
        *) echo "Invalid option $REPLY.";break;;
    esac
  done
}

PS3="Select the folder: "
select folder in "${array[@]}" "Quit"; do
  case $folder in
      "Quit") break;;
      *) calculate $folder;break;;
  esac
done