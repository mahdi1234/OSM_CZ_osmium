#!/bin/bash

mkdir -p ekokom

echo "Amenity recycling"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/amenity=recycling --overwrite -o ./ekokom/all_recycling.pbf
osmium export ./ekokom/all_recycling.pbf --overwrite -o ./ekokom/all_recycling.json -c osmium_options.json
cat ./ekokom/all_recycling.json | grep -e '"amenity":"recycling"' -e 'FeatureCollection' -e '^]}$' | grep -ie 'recycling:' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac > ./ekokom/filtered.json
cat ./ekokom/filtered.json | jq . > ./ekokom/filtered.geojson
