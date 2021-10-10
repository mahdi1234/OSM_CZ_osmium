#!/bin/bash

mkdir -p undefined_recycling

echo "Recycling centre"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/recycling_type=centre --overwrite -o undefined_recycling/recycling_centre.pbf
osmium export undefined_recycling/recycling_centre.pbf --overwrite -o undefined_recycling/recycling_centre.json
cat undefined_recycling/recycling_centre.json | grep -e '"recycling_type":"centre"' -e 'FeatureCollection' -e '^]}$' | grep -vi "recycling:" | tac | sed '2s/,$//' | tac | jq . > ./undefined_recycling/undefined_recycling_centre.geojson

echo "Recycling container"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/recycling_type=container --overwrite -o undefined_recycling/recycling_container.pbf
osmium export undefined_recycling/recycling_container.pbf --overwrite -o undefined_recycling/recycling_container.json
cat undefined_recycling/recycling_container.json | grep -e '"recycling_type":"container"' -e 'FeatureCollection' -e '^]}$' | grep -vi "recycling:" | tac | sed '2s/,$//' | tac | jq . > ./undefined_recycling/undefined_recycling_container.geojson

#echo "Process all jsons"
#sed -i '1 i\\{"type":"FeatureCollection","features":[' ./undefined_recycling/*.geojson
#sed -i '$a ]}' undefined_recycling/*.geojson

echo "Dump progress stats"
> ./undefined_recycling/progress.txt
echo "Sberna strediska" >> ./undefined_recycling/progress.txt
cat ./undefined_recycling/undefined_recycling_centre.geojson | grep 'centre' | wc -l >> ./undefined_recycling/progress.txt
echo "Kontejnery" >> ./undefined_recycling/progress.txt
cat ./undefined_recycling/undefined_recycling_container.geojson | grep 'container' | wc -l >> ./undefined_recycling/progress.txt
echo "Bez typu" >> ./undefined_recycling/progress.txt

echo "Create gpx"
mkdir -p undefined_recycling/gpx
gpsbabel -i geojson -f ./undefined_recycling/undefined_recycling_centre.geojson -o gpx -F ./undefined_recycling/gpx/undefined_recycling_centre.gpx
gpsbabel -i geojson -f ./undefined_recycling/undefined_recycling_container.geojson -o gpx -F ./undefined_recycling/gpx/undefined_recycling_container.gpx
sed -i '/.*time.*/d' undefined_recycling/gpx/*.gpx
