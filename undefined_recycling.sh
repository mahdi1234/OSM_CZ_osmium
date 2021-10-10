#!/bin/bash
mkdir -p undefined_recycling
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/recycling_type=centre --overwrite -o undefined_recycling/recycling_centre.pbf
osmium export undefined_recycling/recycling_centre.pbf --overwrite -o undefined_recycling/recycling_centre.json
cat undefined_recycling/recycling_centre.json | grep -i '"recycling_type":"centre"' | grep -vi "recycling:" > ./undefined_recycling/undefined_recycling_centre.geojson
sed -i '1 i\\{"type":"FeatureCollection","features":[' ./undefined_recycling/*.geojson
sed -i '$a ]}' undefined_recycling/*.geojson
# progress
> ./undefined_recycling/progress.txt
echo "Sberna strediska" >> ./undefined_recycling/progress.txt
cat ./undefined_recycling/undefined_recycling_centre.geojson | grep 'centre' | wc -l >> ./undefined_recycling/progress.txt
#echo "Kontejnery" >> ./progress.txt
#cat ./undefined_recycling_container.json | grep 'container' | wc -l >> ./progress.txt
#echo "Bez typu" >> ./progress.txt
#cat ./undefined_recycling_no_type.json | grep 'amenity' | wc -l >> ./progress.txt