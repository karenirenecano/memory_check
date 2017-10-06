#!/bin/bash
#Author : Karen Cano <karenireneccano@gmail.com>
#Summary: Bash script for memory check

function usage()
{
   echo "Usage    : ${0} [-c <critical%>] [-w <warning%>] [-e <email>]"
   echo "Required : -c , -w , -e"
   echo "Sample   : ${0} -c 90 -w 60 -e email@domain.com"
}

flagChecker=0  #check for flags
re='^[0-9]+$'  #regex for number input checking
issueUsage=0   #check for displaying usage/required parameters

while getopts ":c:w:e:" flag; do
    case ${flag} in
	c)
	   flagChecker=$((++flagChecker))
	   c=${OPTARG};;
	w)
	   flagChecker=$((++flagChecker))
	   w=${OPTARG};;
	e)
	   flagChecker=$((++flagChecker))
	   e=${OPTARG};;
	:)
	   issueUsage=$((++issueUsage));;
	*)
	   issueUsage=$((++issueUsage));;
    esac
done

percentUsage=`free -m | awk 'NR==2{print $3*100/$2}'`
#percentUsage=590 #hard code for testing
memory=`grep MemTotal /proc/meminfo | awk '{printf $2/1024}'`

if [[ $flagChecker == 3 ]]; then
   if ! [ ${c} =~ $re && ${w} =~ $re ]; then
	issueUsage=$((++issueUsage))
   else
	if [ ${c} -lt ${w} ]; then
	   issueUsage=$((++issueUsage))
	else
	   warningPercent=`awk "BEGIN {printf \"%.2f\", ${w}/100}"`
	   crriticalPercent=`awk "BEGIN {print \"%.2f\", ${c}/100}"`
	   memWarn=`awk "BEGIN {printf \"%.0f\", ${warningPercent}*$memory}"`	  
	   memCrit=`awk "BEGIN {printf \"%.0f\", ${criticalPercent}*$memory}"`
	   if [ $percentUsage -ge $memCrit ]; then
		exit 2
	   elif [ $percentUsage -ge $memWarn ] && [ $percentUsage -lt $memCrit ]; then
		exit 1
	   elif [ $percentUsage -lt $memWarn ]; then
		exit 0
	   else
		#exit
	   fi #endif exits
	fi #endif c -lt w checker
   fi #endif regex	
fi #endif flagChecker


if [[ $flagChecker < 3 || $# == 0 || $issueUsage != 0 ]]; then
    usage
fi