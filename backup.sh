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
	echo -e "\n\n${redColour}[!] Exiting...${endColour}"
	exit 1
}

trap ctrl_c INT

function helpPanel(){
	echo -e "\n${grayColour}[+] Use:${endColour}"
	echo -e "\n\t${grayColour}./backup.sh -d [directory to backup]${endColour}\n"
}

function backup(){
	backupDirectory="$1"

	mkdir -p backups
	timestamp=$(date +%Y%m%d_%H%M%S)
	tar -czf backupDirectory_$timestamp.tar.gz $backupDirectory
	mv "backupDirectory_$timestamp.tar.gz" backups

	echo -e "\n\n${greenColour}[+] The directory has been fully backed up and compressed successfully!\n${endColour}"
	time 2
	echo -e "${grayColour}\n[i] Go check in the backups directory!${endColour}\n"
}

declare -i parameter_counter=0

while getopts "d:h" arg; do
	case $arg in
		d) backupDirectory=$OPTARG; let parameter_counter+=1;;
		h) ;;
	esac
done

if [ $parameter_counter -eq 1 ]; then
	backup $backupDirectory
else
	helpPanel
fi
