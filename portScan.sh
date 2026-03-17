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
	echo -e "${redColour}\n\n[!] Exiting...\n${endColour}"
	tput cnorm && exit 1
}

trap ctrl_c SIGINT

function scan(){
	tput civis
	for port in $(seq 1 65535); do
		(echo ''> /dev/tcp/$1/$port) 2>/dev/null && echo -e "\n${greenColour}[+] Host $1 - Port $port (OPEN)${endColour}" &
	done; wait
	tput cnorm
}

function scanPort(){
	tput civis
	(echo ''> /dev/tcp/$1/$2) 2>/dev/null 
	if [ $? -eq 0 ]; then
		echo -e "\n${greenColour}[+] Host $1 - Port $2 (OPEN)${endColour}"
	else
		echo -e "\n${redColour}[!] Port $2 is CLOSED!${endColour}"
	fi
	tput cnorm
}

if [ "$#" -eq 2 ]; then
	scanPort "$1" "$2" 
elif [ "$#" -eq 1 ]; then
	scan "$1"
else
	echo -e "\n${yellowColour}[?]${endColour}${grayColour} Use:${endColour}"
	echo -e "\n\t${grayColour}=>${endColour}${yellowColour} $0${endColour}${grayColour}${turquoiseColour} [ip-address]${endColour}${grayColour} (for general scanning)${endColour}"
	echo -e "\t${grayColour}=>${endColour}${yellowColour} $0${endColour}${grayColour}${turquoiseColour} [ip-address] [port]${endColour}${grayColour} (for specific port scanning)${endColour}\n"
fi
