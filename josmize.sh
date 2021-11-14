#!/bin/bash
## extract @type and @id and then put them into josm remote control url
perl -pe 's/.*?\@type\"\:\"(.*?)\".*?\@id\"\:(.*?)\,.*/$1$2/' | perl -pe 's/way/w/'| perl -pe 's/node/n/' | perl -pe 's/(.*)/curl \"http\:\/\/localhost\:8111\/load_object\?new_layer=false\&objects=$1\"/'

