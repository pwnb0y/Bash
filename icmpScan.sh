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
	echo -e "\n\n[!] Exiting...\n"
	tput cnorm && exit 1
}

trap ctrl_c SIGINT

scan(){
	for i in $(seq 1 254); do
		timeout 1 bash -c "ping -c 1 $1.$i" &>/dev/null && echo -e "\n${grayColour}[+] Host${endColour}${yellowColour} $1.$i${endColour}${grayColour} -${endColour}${greenColour} ACTIVE${endColour}" &		
	done; wait
}

if [ $1 ]; then
	scan $1
else
	echo -e "\n${yellowColour}[?]${endColour}${grayColour} Use:${endColour}"
	echo -e "\n\t${grayColour}=>${endColour}${yellowColour} $0${endColour}${grayColour} [x.x.x] (first 3 octets)${endColour}"
fi
