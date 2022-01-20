#! /bin/bash

clear

function menu {

echo Analyzing logs from "$log" file

while true
do
    echo    "|1 Show All IPs                          |"
    
    read -p "select number: " selection
    
    case $selection in
    1) test;;
	

    esac
    
done
}

function input {
echo -e "Please select the input log:"
ls -p | grep -w log
echo
read log

if [ ! -f $log ]; then
    echo -e "\nFile not found!\n"
    echo -e "Please try again and make sure log file is available in directory"
    getFile
else
    menu
fi
}


function test {
	echo hi
}
input