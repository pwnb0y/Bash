#!/bin/bash

greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){
	echo -e "\n\n${redColour}[!] Exiting...${endColour}\n"
	tput cnorm && exit 1
}

trap ctrl_c INT

clear
echo -e "\n${grayColour}What is your name?:${endColour}\n"
read -p "  ==> " name

date=$(date +%m/%d/%Y)
time=$(date +%H:%M)

if [ $(date +%H) -lt 12 ]; then
	greeting="Good morning" 
elif [ $(date +%H) -ge 12 ]; then
	greeting="Good afternoon" 
elif [ $(date +%H) -ge 18 ];then
	greeting="Good evening"
else
	echo "N/A"
fi

tput civis
echo -e "\n${grayColour}$greeting,${endColour}${yellowColour} $name${endColour}${grayColour}!${endColour}\n"
sleep 2
echo -e "${grayColour}Today is${endColour}${blueColour} $date${endColour}${grayColour}, and it is ${endColour}${blueColour}$time${endColour}${grayColour}...${endColour}\n"
sleep 2
echo -e "${grayColour}Hope you're having a great day today! ;)${endColour}"
sleep 2
tput cnorm
