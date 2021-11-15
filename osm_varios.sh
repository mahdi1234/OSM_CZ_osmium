#!/bin/bash

mkdir -p osm_varios

echo "Battery"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/recycling:*=yes --overwrite -o osm_varios/all_osm_varios.pbf
osmium export osm_varios/all_osm_varios.pbf --overwrite -o osm_varios/all_osm_varios.json -c osmium_options.json
cat osm_varios/all_osm_varios.json | grep -e '"recycling:batteries":"yes"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/battery.geojson

echo "Bulbs"
cat osm_varios/all_osm_varios.json | grep -e '"recycling:light_bulbs":"yes"' -e '"recycling:low_energy_bulbs":"yes"' -e '"recycling:fluorescent_tubes":"yes"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/bulbs.geojson

echo "Cooking oil"
cat osm_varios/all_osm_varios.json | grep -e '"recycling:cooking_oil":"yes"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/cooking_oil.geojson

echo "Metal"
cat osm_varios/all_osm_varios.json | grep -e '"recycling:metal":"yes"' -e '"recycling:scrap_metal":"yes"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/metal.geojson

echo "electric"
cat osm_varios/all_osm_varios.json | grep -e '"recycling:electrical_appliances":"yes"' -e '"recycling:electrical_items":"yes"' -e '"recycling:electronics":"yes"' -e '"recycling:mobile_phones":"yes"' -e '"recycling:small_appliances":"yes"' -e '"recycling:small_electrical_appliances":"yes"' -e '"recycling:white_goods":"yes"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/electric.geojson

echo "bezobalace"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/bulk_purchase=* --overwrite -o osm_varios/bulk.pbf
osmium export osm_varios/bulk.pbf --overwrite -o osm_varios/bulk.json -c osmium_options.json
cat osm_varios/bulk.json | grep -e '"bulk_purchase":"yes"' -e '"bulk_purchase":"only"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/bezobalace.geojson

echo "mlekomaty"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/amenity=vending_machine --overwrite -o osm_varios/vending.pbf
osmium export osm_varios/vending.pbf --overwrite -o osm_varios/vending.json -c osmium_options.json
cat osm_varios/vending.json | grep -e '"milk"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/mlekomaty.geojson

echo "Fire hydrant"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/emergency=fire_hydrant --overwrite -o osm_varios/hydrant.pbf
osmium export osm_varios/hydrant.pbf --overwrite -o osm_varios/hydrant.json -c osmium_options.json
cat osm_varios/hydrant.json | grep -e '"fire_hydrant"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/hydrant.geojson

echo "Steps no count"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/highway=steps --overwrite -o osm_varios/steps_no_count.pbf
osmium export osm_varios/steps_no_count.pbf --overwrite -o osm_varios/steps_no_count.json -c osmium_options.json
cat osm_varios/steps_no_count.json | grep -e '"highway":"steps"' -e 'FeatureCollection' -e '^]}$' | grep -vi "count" | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/steps_no_count.geojson

echo "Public bookcase"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/amenity=public_bookcase --overwrite -o osm_varios/bookcase.pbf
osmium export osm_varios/bookcase.pbf --overwrite -o osm_varios/bookcase.json -c osmium_options.json
cat osm_varios/bookcase.json | grep -e '"public_bookcase"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/bookcase.geojson

echo "AED"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/emergency=defibrillator --overwrite -o osm_varios/aed.pbf
osmium export osm_varios/aed.pbf --overwrite -o osm_varios/aed.json -c osmium_options.json
cat osm_varios/aed.json | grep -e '"defibrillator"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/aed.geojson

echo "Beer"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/shop=alcohol --overwrite -o osm_varios/alcohol.pbf
osmium export osm_varios/alcohol.pbf --overwrite -o osm_varios/alcohol.json -c osmium_options.json
cat osm_varios/alcohol.json | grep -e '"alcohol"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/alcohol.geojson
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/drink:beer=* --overwrite -o osm_varios/beershop.pbf
osmium export osm_varios/beershop.pbf --overwrite -o osm_varios/beershop.json -c osmium_options.json
cat osm_varios/beershop.json | grep -e '"shop"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./osm_varios/beershop.geojson

echo "Uzavirky"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/vehicle:conditional=* --overwrite -o ./osm_varios/uzavirky.pbf
osmium export ./osm_varios/uzavirky.pbf --overwrite -o ./osm_varios/uzavirky_temp.json -c osmium_options.json
cat ./osm_varios/uzavirky_temp.json | grep -e '"vehicle:conditional":"no @' -e 'FeatureCollection' -e '^]}$' > ./osm_varios/uzavirky.json
# exampples "no @ (2019 Oct 09 - 2019 Oct 14)" no @ (2021 Mar 15 - 2021 May 31 AND weight>3,5)
# should exlude "no @ (Mo-Fr 06:00-20:00)" as well later
today=`date +"%Y%m%d"`
echo $today
cat ./osm_varios/uzavirky.json | perl -pe 's/(.*no \@.*?\-.*?)(\d\d\d\d.*?\d\d)(.*)/$1$2$3\t$2/' | dateutils.dconv -i "%Y %b %d" -f %Y%m%d -S | awk 'BEGIN { FS="\t" } $2>='$today' {print $1}' > ./osm_varios/uzavirky_aktualni.json
echo '{"type":"FeatureCollection","features":[' > ./osm_varios/uzavirky_final.json
cat ./osm_varios/uzavirky_aktualni.json >> ./osm_varios/uzavirky_final.json
echo ']}' >> ./osm_varios/uzavirky_final.json
cat ./osm_varios/uzavirky.json | perl -pe 's/(.*no \@.*?\-.*?)(\d\d\d\d.*?\d\d)(.*)/$1$2$3\t$2/' | dateutils.dconv -i "%Y %b %d" -f %Y%m%d -S | awk 'BEGIN { FS="\t" } $2<='$today' {print $1}' | grep -v '"vehicle:conditional":"delivery @' | grep -v '"vehicle:conditional":"no @ (Mo-Fr' > ./osm_varios/uzavirky_neaktualni.json
echo '#!/bin/bash' > ./osm_varios/uzavirky_JOSM.sh
cat ./osm_varios/uzavirky_neaktualni.json | ./josmize.sh >> ./osm_varios/uzavirky_JOSM.sh
