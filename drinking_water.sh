#!/bin/bash

mkdir -p drinking_water

echo "amenity=drinking_water"
osmium tags-filter ./praha-latest.osm.pbf nwr/amenity=drinking_water --overwrite -o ./drinking_water/amenity_drinking_water.pbf
osmium export ./drinking_water/amenity_drinking_water.pbf --overwrite -o ./drinking_water/amenity_drinking_water.json -c ./osmium_options.json
cat ./drinking_water/amenity_drinking_water.json | ./urlize.sh | grep -e '"amenity":"drinking_water"' -e 'FeatureCollection' -e '^]}$' | grep -ve '"access":"private"' | grep -ve '"access":"customers"' | grep -ve '"access":"no"' |  ./sanitize_json_jq.sh > ./drinking_water/funknci_verejna_pitka.geojson
cat ./drinking_water/amenity_drinking_water.json | ./urlize.sh | grep -e '"amenity":"drinking_water"' -e 'FeatureCollection' -e '^]}$' | grep -e '"fountain":"brčko"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./drinking_water/brcka_mlhopitka.geojson
cat ./drinking_water/amenity_drinking_water.json | ./urlize.sh | grep -e '"amenity":"drinking_water"' -e 'FeatureCollection' -e '^]}$' | grep -e '"access":"private"' -e '"access":"customers"' -e '"access":"no"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./drinking_water/soukroma_pitka.geojson

echo "disused:amenity=drinking_water"
osmium tags-filter ./praha-latest.osm.pbf nwr/disused:amenity=drinking_water --overwrite -o ./drinking_water/disused_amenity_drinking_water.pbf
osmium export ./drinking_water/disused_amenity_drinking_water.pbf --overwrite -o ./drinking_water/disused_amenity_drinking_water.json -c ./osmium_options.json
cat ./drinking_water/disused_amenity_drinking_water.json | ./urlize.sh | grep -e '"disused:amenity":"drinking_water"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./drinking_water/nefunkcni_pitka.geojson

echo "other drinkig water sources"
osmium tags-filter ./praha-latest.osm.pbf nwr/drinking_water=yes --overwrite -o ./drinking_water/other_drinking_water.pbf
osmium export ./drinking_water/other_drinking_water.pbf --overwrite -o ./drinking_water/other_drinking_water.json -c ./osmium_options.json
cat ./drinking_water/other_drinking_water.json | ./urlize.sh | grep -e '"drinking_water":"yes"' -e 'FeatureCollection' -e '^]}$' | grep -ve '"amenity":"drinking_water"' | ./sanitize_json_jq.sh > ./drinking_water/jine_zdroje_pitne_vody.geojson

echo "amenity=mist_spraying_cooler"
osmium tags-filter ./praha-latest.osm.pbf nwr/amenity=mist_spraying_cooler --overwrite -o ./drinking_water/mist_spaying_cooler.pbf
osmium export ./drinking_water/mist_spaying_cooler.pbf --overwrite -o ./drinking_water/mist_spaying_cooler.json -c ./osmium_options.json
cat ./drinking_water/mist_spaying_cooler.json | ./urlize.sh | grep -e '"amenity":"mist_spraying_cooler"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./drinking_water/mlzitka.geojson

