#!/bin/bash
# using arrow keys to navigate through the menu
##### setup #####
# - chmod +x docker-compose-manager.sh
# - create alias for the command: alias docker-compose-manager='/path/to/docker-compose-manager.sh'
# usage: run the command: docker-compose-manager

array1=()
while IFS=  read -r -d $'\n'; do
    array1+=("$REPLY")
done < <(find /home/ -regex '.*/docker-compose.ya?ml' -printf '%h\n' | sort -u)
array1+=( "Quit" )

#array1=($(ls -d */))
#array1+=( "Quit" )

function print_menu()  # header_text, selected_item, ...menu_items
{
	local header_text="$1"
	shift
	local selected_item="$1"
	shift
#	local function_arguments=($@)
#	local menu_items=(${function_arguments[@]:2})
	local menu_items=($@)
	local menu_size="${#menu_items[@]}"

  echo "${menu_items[*]}"
  echo "############### docker-compose Manager v0.1 ###############"
  echo "############### $header_text ###############"
	for (( i = 0; i < $menu_size; ++i ))
	do
		if [ "$i" = "$selected_item" ]
		then
			echo "$i ---> ${menu_items[i]}"
		else
			echo "$i -    ${menu_items[i]}"
		fi
	done
}

function run_menu()  # header_text, selected_item, ...menu_items
{
	local header_text="$1"
	shift
	local selected_item="$1"
	shift
#	local function_arguments=($@)
#	local menu_items=(${function_arguments[@]:2})
	local menu_items=($@)
	local menu_size="${#menu_items[@]}"
	local menu_limit=$((menu_size - 1))

	clear
	print_menu "$header_text" "$selected_item" "${menu_items[@]}"

	while read -rsn1 input
	do
		case "$input"
		in
			$'\x1B')  # ESC ASCII code (https://dirask.com/posts/ASCII-Table-pJ3Y0j)
				read -rsn1 -t 0.1 input
				if [ "$input" = "[" ]  # occurs before arrow code
				then
					read -rsn1 -t 0.1 input
					case "$input"
					in
						A)  # Up Arrow
							if [ "$selected_item" -ge 1 ]
							then
								selected_item=$((selected_item - 1))
								clear
								print_menu "$header_text" "$selected_item" "${menu_items[@]}"
							else
#							  selected_item=$((menu_limit - 1))
							  selected_item=$menu_limit
							  clear
							  print_menu "$header_text" "$selected_item" "${menu_items[@]}"
							fi
							;;
						B)  # Down Arrow
							if [ "$selected_item" -lt "$menu_limit" ]
							then
								selected_item=$((selected_item + 1))
								clear
								print_menu "$header_text" "$selected_item" "${menu_items[@]}"
              else # selected_item = menu_limit
                selected_item=0
                clear
                print_menu "$header_text" "$selected_item" "${menu_items[@]}"
							fi
							;;
					esac
				fi
				read -rsn5 -t 0.1  # flushing stdin
				;;
			"")  # Enter key
				return "$selected_item"
				;;
		esac
	done
}

selected_item1=0
menu_header1="choose a folder: "
# echo "Select the folder: "
run_menu "$menu_header1" "$selected_item1" "${array1[@]}"
menu_result1="${array1[$?]}"
folder=$menu_result1
# echo $menu_result1
clear

if [ "$folder" = "Quit" ]  # Quit
then
    clear
    exit 0
fi



menu_header2=""
if [ -z $(cd $folder && docker-compose ps) ]
then
  menu_header2="$folder: down => choose an operation: "
else
  menu_header2="$folder: up => choose an operation: "
fi

selected_item2=0
array2=("up" "down" "restart" "resync" "Quit")
# echo "Select the operation: "
run_menu "$menu_header2" "$selected_item2" "${array2[@]}"
menu_result2="${array2[$?]}"
operation=$menu_result2
# echo $menu_result2
clear

if [ "$operation" = "Quit" ]  # Quit
then
    clear
    exit 0
fi

echo "-------- RUN COMMAND $operation ON $folder --------"

run_operation(){
    case $2 in
      "resync") cd $1 && docker-compose down && git pull && docker-compose up -d && cd /home/;exit;;
      "restart") cd $1 && docker-compose down && docker-compose up -d && cd /home/;exit;;
      "up") cd $1 && docker-compose up -d && cd /home/;exit;;
      "down") cd $1 && docker-compose down && cd /home/;exit;;
      "Quit") exit;;
      *) echo "Invalid option $1 with $2.";exit;;
  esac
}

case "$folder" in
    "Quit") exit;;
    *) run_operation $folder $operation;exit;;
esac