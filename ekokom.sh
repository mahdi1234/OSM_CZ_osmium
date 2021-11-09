#!/bin/bash

mkdir -p ekokom

echo "Amenity recycling"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/amenity=recycling --overwrite -o ./ekokom/all_recycling.pbf
osmium export ./ekokom/all_recycling.pbf --overwrite -o ./ekokom/all_recycling.json -c osmium_options.json
cat ./ekokom/all_recycling.json | grep -e '"amenity":"recycling"' -e 'FeatureCollection' -e '^]}$' | grep -ie 'recycling:' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac > ./ekokom/filtered.json
cat ./ekokom/filtered.json | jq . > ./ekokom/filtered.geojson

echo "Dump progress stats"
> ./ekokom/progress.txt
echo "Vsechna mista" >> ./ekokom/progress.txt
cat ./ekokom/all_recycling.json | grep 'amenity' | wc -l >> ./ekokom/progress.txt
echo "S typem odpadu" >> ./ekokom/progress.txt
cat ./ekokom/filtered.geojson | grep 'amenity' | wc -l >> ./ekokom/progress.txt
