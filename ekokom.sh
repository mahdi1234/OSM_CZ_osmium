#!/bin/bash

mkdir -p ekokom

echo "Amenity recycling"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/amenity=recycling --overwrite -o ./ekokom/all_recycling.pbf
osmium export ./ekokom/all_recycling.pbf --overwrite -o ./ekokom/all_recycling_temp.json -c ./osmium_options.json
cat ./ekokom/all_recycling_temp.json | grep -vi 'LineString' > ./ekokom/all_recycling.json
cat ./ekokom/all_recycling.json | grep -e '"amenity":"recycling"' -e 'FeatureCollection' -e '^]}$' | grep -ie 'recycling:' -e '"recycling_type":"centre"' -e 'FeatureCollection' -e '^]}$' | grep -e 'FeatureCollection' -e 'recycling:' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json.sh > ./ekokom/filtered.json
cat ./ekokom/filtered.json | jq . > ./ekokom/filtered.geojson

echo "Dump progress stats"
> ./ekokom/progress.txt
echo "Vsechna mista" >> ./ekokom/progress.txt
cat ./ekokom/all_recycling.json | grep '"amenity":"recycling"' | wc -l >> ./ekokom/progress.txt
echo "Kontejnery" >> ./ekokom/progress.txt
cat ./ekokom/all_recycling.json | grep '"recycling_type":"container"' | wc -l >> ./ekokom/progress.txt
echo "Sberny dvory" >> ./ekokom/progress.txt
cat ./ekokom/all_recycling.json | grep '"recycling_type":"centre"' | wc -l >> ./ekokom/progress.txt
echo "S typem odpadu" >> ./ekokom/progress.txt
cat ./ekokom/filtered.json | grep 'amenity' | wc -l >> ./ekokom/progress.txt
