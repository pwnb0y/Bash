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

function helpPanel(){
	echo -e "\n${blueColour}[i]${endColour}${grayColour} Use:${endColour}"
	echo -e "\n\t${grayColour}./fileOrganizer -d [directory to organize]${endColour}\n"
}

function organize(){

	if [ -z "$(ls -A "$directoryToOrganize")" ]; then
		echo -e "\n${blueColour}[i]${endColour}${grayColour} No files to organize!${endColour}\n"
	else
		tput civis
		echo -e "\n${yellowColour}[...]${endColour}${grayColour} Starting to organize files...${endColour}\n"

		sleep 2

		mkdir -p $HOME/Documents
		mkdir -p $HOME/Pictures
		mkdir -p $HOME/Videos
		mkdir -p $HOME/Music

		mv  *.pdf  *doc *docx *.txt *.ppt $HOME/Documents 2>/dev/null
		mv *.jpg *.jpeg *.png *.gif $HOME/Pictures 2>/dev/null
		mv *.mp4 *.avi *.mov *.mkv $HOME/Videos 2>/dev/null
		mv *.mp3 *.wav *.flac *.aac $HOME/Music 2>/dev/null

		echo -e "\n${greenColour}[+] All files organized successfully!${endColour}\n"

		sleep 1
		tput cnorm
	fi
}

declare -i parameter_counter=0

while getopts "d:h" arg; do
	case $arg in
		d) directoryToOrganize=$OPTARG; let parameter_counter+=1;;
		h) ;;
	esac
done

if [ $parameter_counter -eq 1 ]; then
	organize $directoryToOrganize
else
	helpPanel
fi
