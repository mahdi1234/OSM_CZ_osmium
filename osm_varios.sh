#!/bin/bash

mkdir -p osm_varios

echo "Battery"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/recycling:*=yes --overwrite -o osm_varios/all_osm_varios.pbf
osmium export osm_varios/all_osm_varios.pbf --overwrite -o osm_varios/all_osm_varios.json
cat osm_varios/all_osm_varios.json | grep -e '"recycling:batteries":"yes"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/battery.geojson

echo "Bulbs"
cat osm_varios/all_osm_varios.json | grep -e '"recycling:light_bulbs":"yes"' -e '"recycling:low_energy_bulbs":"yes"' -e '"recycling:fluorescent_tubes":"yes"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/bulbs.geojson

echo "Cooking oil"
cat osm_varios/all_osm_varios.json | grep -e '"recycling:cooking_oil":"yes"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/cooking_oil.geojson

echo "Metal"
cat osm_varios/all_osm_varios.json | grep -e '"recycling:metal":"yes"' -e '"recycling:scrap_metal":"yes"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/metal.geojson

echo "bezobalace"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/bulk_purchase=* --overwrite -o osm_varios/bulk.pbf
osmium export osm_varios/bulk.pbf --overwrite -o osm_varios/bulk.json
cat osm_varios/bulk.json | grep -e '"bulk_purchase":"yes"' -e '"bulk_purchase":"only"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/bezobalace.geojson

echo "mlekomaty"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/amenity=vending_machine --overwrite -o osm_varios/vending.pbf
osmium export osm_varios/vending.pbf --overwrite -o osm_varios/vending.json
cat osm_varios/vending.json | grep -e '"milk"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/mlekomaty.geojson

echo "Fire hydrant"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/emergency=fire_hydrant --overwrite -o osm_varios/hydrant.pbf
osmium export osm_varios/hydrant.pbf --overwrite -o osm_varios/hydrant.json
cat osm_varios/hydrant.json | grep -e '"fire_hydrant"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/hydrant.geojson

echo "Steps no count"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/highway=steps --overwrite -o osm_varios/steps_no_count.pbf
osmium export osm_varios/steps_no_count.pbf --overwrite -o osm_varios/steps_no_count.json
cat osm_varios/steps_no_count.json | grep -e '"highway":"steps"' -e 'FeatureCollection' -e '^]}$' | grep -vi "count" | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/steps_no_count.geojson

echo "Public bookcase"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/amenity=public_bookcase --overwrite -o osm_varios/bookcase.pbf
osmium export osm_varios/bookcase.pbf --overwrite -o osm_varios/bookcase.json
cat osm_varios/bookcase.json | grep -e '"public_bookcase"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/bookcase.geojson

echo "AED"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/emergency=defibrillator --overwrite -o osm_varios/aed.pbf
osmium export osm_varios/aed.pbf --overwrite -o osm_varios/aed.json
cat osm_varios/aed.json | grep -e '"defibrillator"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/aed.geojson
