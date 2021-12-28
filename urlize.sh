#!/bin/bash
## extract @type and @id and then put them into @url variable
perl -pe 's/(.*\@type":")(.*?)(".*\@id":)(.*?)(,".*)/$1$2$3$4,"\@url":"https:\/\/www.openstreetmap.org\/$2\/$4"$5/'
