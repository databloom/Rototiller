#!/bin/bash

#hint: make this a usb drive with lots of space to avoid swamping your dev workstation:

filerepo="/media/bloomm2/Tardis/filerepo"


# change --limit-rate=50k to a bigger or smaller value if you aren't on home link

for i in `cat linkstoscrape.txt | sed 's/.*http/http/g'  | sed "s/',//g" | sort | uniq`; do wget -nc --limit-rate=50k -P $filerepo $i;done

