#! /bin/bash

clear

function menu {

echo Analyzing logs from "$log" file

while true
do
    echo    "1- Show IPs"
    echo    "2- most_visit_URLs"
    echo    "3- topIPs"
    echo    "4- popular_browser"
    echo    "5- maxvisitorsOS"

    read -p "select number: " selection
    
    case $selection in
    1) showIPs;;
	2) most_visit_URLs;;
    3) topIPs;;
    4) popular_browser;;
    5) maxvisitorsOS;;

    esac
    
done
}

function input {
echo -e "Please select log:"
ls -p | grep -w log
echo
read log

if [ ! -f $log ]; then
    echo -e "\nFile not found!\n"
    echo -e "Please try again"
    getFile
else
    menu
fi
}


function showIPs {
    cat $log | awk '{ print $1}' | sort | uniq | wc | awk '{print $1 " IPs without repetition found" }'
    cat $log | awk -F\" '{ print $1 }'| wc | awk '{print "All of IPs are: " $1}'
    cat $log | awk '{ print count "times {" $1 "} IP is repeated."}' | sort -r | uniq -c | sort -r
    cat $log | awk '{ print $1}' | uniq > allIPs.txt
}

function most_visit_URLs {
    echo 10 Most URLs Visited:
    awk '{count[$7]++} END {for (url in count) print url, count[url]}' $log | sort -k 2nr | head -n 10
    awk '{count[$7]++} END {for (url in count) print url, count[url]}' $log | sort -k 2nr | head -n 10 > MostVisitedURLs.txt
}

function topIPs {
    cat $log | awk '{ print $1}' | sort | uniq | wc | awk '{print $1 " IPs without repetition found" }'
    cat $log | awk -F\" '{ print $1 }'| wc | awk '{print "All of IPs are: " $1}'
    echo Top 20 IPs:
    awk '{print count "times {" $1 "} IP is repeated."}' $log | sort | uniq -c  | sort -nr | head -n 20
    awk '{print count "times {" $1 "} IP is repeated."}' $log | sort | uniq -c  | sort -nr | head -n 20 > TopIPs.txt
}

function popular_browser {
    awk '{brow[$(NF)]++} END {for (item in brow) print item, brow[item]}' $file | sort -k 2nr | head -n 10 > "$file1"popularBrowsers.txt
    figlet Result
    printf "You can see this file in this directory that show list of top 10 browser.\n\n"
    printf '1- *popularBrowsers.txt\n\n'
}

function maxvisitorsOS {
    echo Top 5 visitors Opeation Systems:
    awk '{count[$13]++} END {for (os in count) print os, count[os]}' $log | sort -k 2nr | head -n 5
    awk '{count[$13]++} END {for (os in count) print os, count[os]}' $log | sort -k 2nr | head -n 5 > VisitorsOS.txt
}

input