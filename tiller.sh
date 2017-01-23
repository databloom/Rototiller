#!/bin/bash


#This is really just a wrapper for google scraper, it picks a random word from a dictionary, iterates through a list of suffixes and searches google for files that match to word search and suffix file type. 




extlist='extensions.txt'

#source for our extensions, tune to suit your needs

dict='/usr/share/dict/words'
# source for our google search. Look for files with this search element, indexed by google, with a particular suffix.

n=$( cat "$dict" | wc -l )
#how big is our dictionary
rnd=$( date '+%N' | sed 's/^[0]*//' )
#pick a random number
lnum=$(( rnd % n + 1 ))
#align this with the index of our dictionary
word=$( awk -v lnum=$lnum 'NR==lnum { print }' "$dict" | sed "s/'/%27/g" )
#spit out a word
echo $word 

#launch wgetwrapper to pick up previously indexed files and put them into the filerepo

test=`bash wgetwrapper.sh & `


#iterate through the extentions with our word.

for extension in `cat tempextensions.txt`;
do


echo "$word filetype:$extension"
GoogleScraper -m http -p 1 -n 75 -q "$word filetype:$extension" | grep "http://" | grep "$extension" | grep link >>linkstoscrape.txt

done


