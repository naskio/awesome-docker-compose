#!/bin/bash
# using arrow keys to navigate through the menu

array=()
while IFS=  read -r -d $'\n'; do
    array+=("$REPLY")
done < <(find /home/ -regex '.*/docker-compose.ya?ml' -printf '%h\n' | sort -u)
array+=( "Quit" )

#array=($(ls -d */))
#array+=( "Quit" )

function print_menu()  # selected_item, ...menu_items
{
	local function_arguments=($@)

	local selected_item="$1"
	local menu_items=(${function_arguments[@]:1})
	local menu_size="${#menu_items[@]}"

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

function run_menu()  # selected_item, ...menu_items
{
	local function_arguments=($@)

	local selected_item="$1"
	local menu_items=(${function_arguments[@]:1})
	local menu_size="${#menu_items[@]}"
	local menu_limit=$((menu_size - 1))

	clear
	print_menu "$selected_item" "${menu_items[@]}"

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
								print_menu "$selected_item" "${menu_items[@]}"
							else
							  selected_item=$((menu_limit - 1))
							  clear
							  print_menu "$selected_item" "${menu_items[@]}"
							fi
							;;
						B)  # Down Arrow
							if [ "$selected_item" -lt "$menu_limit" ]
							then
								selected_item=$((selected_item + 1))
								clear
								print_menu "$selected_item" "${menu_items[@]}"
              else # selected_item = menu_limit
                selected_item=0
                clear
                print_menu "$selected_item" "${menu_items[@]}"
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

selected_item=0
echo "Select the folder: "
run_menu "$selected_item" "${array[@]}"
menu_result="${array[$?]}"
folder=$menu_result
echo $menu_result
clear

if [ "$folder" = "Quit" ]  # Quit
then
    clear
    exit 0
fi

selected_item1=0
array1=("up" "down" "restart" "resync" "Quit")
echo "Select the operation: "
run_menu "$selected_item1" "${array1[@]}"
menu_result1="${array1[$?]}"
operation=$menu_result1
echo $menu_result1
clear

if [ "$operation" = "Quit" ]  # Quit
then
    clear
    exit 0
fi

echo "-------- running command $operation on $folder --------"

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