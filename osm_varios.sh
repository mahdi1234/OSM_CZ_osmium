#!/bin/bash

mkdir -p osm_varios

echo "Battery"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/recycling:*=yes --overwrite -o ./osm_varios/all_osm_varios.pbf
osmium export ./osm_varios/all_osm_varios.pbf --overwrite -o ./osm_varios/all_osm_varios.json -c ./osmium_options.json
cat ./osm_varios/all_osm_varios.json | ./urlize.sh | grep -e '"recycling:batteries":"yes"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/battery.geojson

echo "Bulbs"
cat ./osm_varios/all_osm_varios.json | ./urlize.sh | grep -e '"recycling:light_bulbs":"yes"' -e '"recycling:low_energy_bulbs":"yes"' -e '"recycling:fluorescent_tubes":"yes"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/bulbs.geojson

echo "Cooking oil"
cat ./osm_varios/all_osm_varios.json | ./urlize.sh | grep -e '"recycling:cooking_oil":"yes"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/cooking_oil.geojson

echo "Metal"
cat ./osm_varios/all_osm_varios.json | ./urlize.sh | grep -e '"recycling:metal":"yes"' -e '"recycling:scrap_metal":"yes"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/metal.geojson

echo "electric"
cat ./osm_varios/all_osm_varios.json | ./urlize.sh | grep -e '"recycling:electrical_appliances":"yes"' -e '"recycling:electrical_items":"yes"' -e '"recycling:electronics":"yes"' -e '"recycling:mobile_phones":"yes"' -e '"recycling:small_appliances":"yes"' -e '"recycling:small_electrical_appliances":"yes"' -e '"recycling:white_goods":"yes"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/electric.geojson

echo "Czech recycling clothes without shoes"
cat ./osm_varios/all_osm_varios.json | ./urlize.sh | grep -e '"recycling:clothes":"yes"' -e 'FeatureCollection' -e '^]}$' | grep -ve '"recycling:shoes":"yes"' | ./sanitize_json_jq.sh > ./osm_varios/czech_container_no_shoes.geojson
echo '#!/bin/bash' > ./osm_varios/czech_container_no_shoes_JOSM.sh
cat ./osm_varios/all_osm_varios.json | ./urlize.sh | grep -e '"recycling:clothes":"yes"' -e 'FeatureCollection' -e '^]}$' | grep -ve '"recycling:shoes":"yes"' | ./josmize.sh >> ./osm_varios/czech_container_no_shoes_JOSM.sh

echo "Czech recycling shoes without clothes"
cat ./osm_varios/all_osm_varios.json | ./urlize.sh | grep -e '"recycling:shoes":"yes"' -e 'FeatureCollection' -e '^]}$' | grep -ve '"recycling:clothes":"yes"' | ./sanitize_json_jq.sh > ./osm_varios/czech_container_no_clothes.geojson
echo '#!/bin/bash' > ./osm_varios/czech_container_no_clothes_JOSM.sh
cat ./osm_varios/all_osm_varios.json | ./urlize.sh | grep -e '"recycling:shoes":"yes"' -e 'FeatureCollection' -e '^]}$' | grep -ve '"recycling:clothes":"yes"' | ./josmize.sh >> ./osm_varios/czech_container_no_clothes_JOSM.sh


echo "bezobalace"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/bulk_purchase=* --overwrite -o ./osm_varios/bulk.pbf
osmium export ./osm_varios/bulk.pbf --overwrite -o ./osm_varios/bulk.json -c ./osmium_options.json
cat ./osm_varios/bulk.json | ./urlize.sh | grep -e '"bulk_purchase":"yes"' -e '"bulk_purchase":"only"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/bezobalace.geojson

echo "mlekomaty"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/amenity=vending_machine --overwrite -o ./osm_varios/vending.pbf
osmium export ./osm_varios/vending.pbf --overwrite -o ./osm_varios/vending.json -c ./osmium_options.json
cat ./osm_varios/vending.json | ./urlize.sh | grep -e '"milk"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/mlekomaty.geojson

echo "pivomaty"
cat ./osm_varios/vending.json | ./urlize.sh | grep -e '"beer"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/pivomaty.geojson

echo "Fire hydrant"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/emergency=fire_hydrant --overwrite -o ./osm_varios/hydrant.pbf
osmium export ./osm_varios/hydrant.pbf --overwrite -o ./osm_varios/hydrant.json -c ./osmium_options.json
cat ./osm_varios/hydrant.json | ./urlize.sh | grep -e '"fire_hydrant"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/hydrant.geojson

echo "Steps no count"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/highway=steps --overwrite -o ./osm_varios/steps_no_count.pbf
osmium export ./osm_varios/steps_no_count.pbf --overwrite -o ./osm_varios/steps_no_count.json -c ./osmium_options.json
cat ./osm_varios/steps_no_count.json | ./urlize.sh | grep -e '"highway":"steps"' -e 'FeatureCollection' -e '^]}$' | grep -vi "count" | ./sanitize_json_jq.sh > ./osm_varios/steps_no_count.geojson

echo "Public bookcase"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/amenity=public_bookcase --overwrite -o ./osm_varios/bookcase.pbf
osmium export ./osm_varios/bookcase.pbf --overwrite -o ./osm_varios/bookcase.json -c ./osmium_options.json
cat ./osm_varios/bookcase.json | ./urlize.sh | grep -e '"public_bookcase"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/bookcase.geojson

echo "AED"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/emergency=defibrillator --overwrite -o ./osm_varios/aed.pbf
osmium export ./osm_varios/aed.pbf --overwrite -o ./osm_varios/aed.json -c ./osmium_options.json
cat ./osm_varios/aed.json | ./urlize.sh | grep -e '"defibrillator"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/aed.geojson

echo "Beer"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/shop=alcohol --overwrite -o ./osm_varios/alcohol.pbf
osmium export ./osm_varios/alcohol.pbf --overwrite -o ./osm_varios/alcohol.json -c ./osmium_options.json
cat ./osm_varios/alcohol.json | ./urlize.sh | grep -e '"alcohol"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/alcohol.geojson
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/drink:beer=* --overwrite -o ./osm_varios/beershop.pbf
osmium export ./osm_varios/beershop.pbf --overwrite -o ./osm_varios/beershop.json -c ./osmium_options.json
cat ./osm_varios/beershop.json | ./urlize.sh | grep -e '"shop"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/beershop.geojson
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/shop=beverages --overwrite -o ./osm_varios/beverages.pbf
osmium export ./osm_varios/beverages.pbf --overwrite -o ./osm_varios/beverages.json -c ./osmium_options.json
cat ./osm_varios/beverages.json | ./urlize.sh | grep -e '"beverages"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/beverages.geojson

echo "Uzavirky"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/vehicle:conditional=* --overwrite -o ./osm_varios/uzavirky.pbf
osmium export ./osm_varios/uzavirky.pbf --overwrite -o ./osm_varios/uzavirky_temp.json -c ./osmium_options.json
cat ./osm_varios/uzavirky_temp.json | ./urlize.sh | grep -e '"vehicle:conditional":"no @' -e 'FeatureCollection' -e '^]}$' > ./osm_varios/uzavirky.json
# exampples "no @ (2019 Oct 09 - 2019 Oct 14)" no @ (2021 Mar 15 - 2021 May 31 AND weight>3,5)
# should exlude "no @ (Mo-Fr 06:00-20:00)" as well later
today=`date +"%Y%m%d"`
echo $today
cat ./osm_varios/uzavirky.json | perl -pe 's/(.*no \@.*?\-.*?)(\d\d\d\d.*?\d\d)(.*)/$1$2$3\t$2/' | dateutils.dconv -i "%Y %b %d" -f %Y%m%d -S | awk 'BEGIN { FS="\t" } $2>='$today' {print $1}' > ./osm_varios/uzavirky_aktualni.json
echo '{"type":"FeatureCollection","features":[' > ./osm_varios/uzavirky.geojson
cat ./osm_varios/uzavirky_aktualni.json | tac | sed '1s/,$//' | tac >> ./osm_varios/uzavirky.geojson
echo ']}' >> ./osm_varios/uzavirky.geojson
cat ./osm_varios/uzavirky.json | perl -pe 's/(.*no \@.*?\-.*?)(\d\d\d\d.*?\d\d)(.*)/$1$2$3\t$2/' | dateutils.dconv -i "%Y %b %d" -f %Y%m%d -S | awk 'BEGIN { FS="\t" } $2<='$today' {print $1}' | grep -v '"vehicle:conditional":"delivery @' | grep -v '"vehicle:conditional":"no @ (Mo-Fr' > ./osm_varios/uzavirky_neaktualni.json
echo '#!/bin/bash' > ./osm_varios/uzavirky_JOSM.sh
cat ./osm_varios/uzavirky_neaktualni.json | ./josmize.sh >> ./osm_varios/uzavirky_JOSM.sh

echo "Rescue point"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/highway=emergency_access_point --overwrite -o ./osm_varios/rescue.pbf
osmium export ./osm_varios/rescue.pbf --overwrite -o ./osm_varios/rescue.json -c ./osmium_options.json
cat ./osm_varios/rescue.json | ./urlize.sh | grep -e '"emergency_access_point"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/rescue.geojson

echo "Schranky bez ref"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/amenity=post_box --overwrite -o ./osm_varios/postbox.pbf
osmium export ./osm_varios/postbox.pbf --overwrite -o ./osm_varios/postbox.json -c ./osmium_options.json
cat ./osm_varios/postbox.json | ./urlize.sh | grep -e '"post_box"' -e 'FeatureCollection' -e '^]}$' | grep -v '"ref"' | ./sanitize_json_jq.sh > ./osm_varios/postbox.geojson
echo "Create gpx"
mkdir -p ./osm_varios/gpx
gpsbabel -i geojson -f ./osm_varios/postbox.geojson -o gpx -F ./osm_varios/gpx/schranky_bez_ref.gpx
sed -i '/.*time.*/d' ./osm_varios/gpx/*.gpx

echo "Micro brewery"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/craft=brewery microbrewery=yes --overwrite -o ./osm_varios/brewery.pbf
osmium export ./osm_varios/brewery.pbf --overwrite -o ./osm_varios/brewery.json -c ./osmium_options.json
cat ./osm_varios/brewery.json | ./urlize.sh | grep -e 'brewery' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/brewery.geojson

echo "Vegan"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/diet:vegan=only --overwrite -o ./osm_varios/all_vege.pbf
osmium export ./osm_varios/all_vege.pbf --overwrite -o ./osm_varios/all_vege.json -c ./osmium_options.json
cat ./osm_varios/all_vege.json | ./urlize.sh | grep -e '"diet:vegetarian":"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/vege.geojson

echo "Beehive"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/man_made=beehive nwr/landuse=apiary --overwrite -o ./osm_varios/beehive.pbf
osmium export ./osm_varios/beehive.pbf --overwrite -o ./osm_varios/beehive.json -c ./osmium_options.json
cat ./osm_varios/beehive.json | ./urlize.sh | grep -e '"beehive"' -e '"apiary"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/beehive.geojson

echo "Brno recycling plastic"
osmium tags-filter ./brno-latest.osm.pbf nwr/recycling_type=container --overwrite -o ./osm_varios/brno_container.pbf
osmium export ./osm_varios/brno_container.pbf --overwrite -o ./osm_varios/brno_container.json -c ./osmium_options.json
cat ./osm_varios/brno_container.json | ./urlize.sh | grep -e '"recycling:plastic":"yes"' -e '"recycling:plastic_bottles":"yes"' -e 'FeatureCollection' -e '^]}$' | grep -ve '"recycling:cans":"yes"' | grep -ve '"recycling:scrap_metal":"yes"' | grep -ve '"access":"private"' | ./sanitize_json_jq.sh > ./osm_varios/brno_container.geojson
echo '#!/bin/bash' > ./osm_varios/brno_container_JOSM.sh
cat ./osm_varios/brno_container.json | ./urlize.sh | grep -e '"recycling:plastic":"yes"' -e '"recycling:plastic_bottles":"yes"' -e 'FeatureCollection' -e '^]}$' | grep -ve '"recycling:cans":"yes"' | grep -ve '"recycling:scrap_metal":"yes"' | grep -ve '"access":"private"' | ./josmize.sh >> ./osm_varios/brno_container_JOSM.sh

echo "Brno recycling clothes without shoes"
cat ./osm_varios/brno_container.json | ./urlize.sh | grep -e '"recycling:clothes":"yes"' -e 'FeatureCollection' -e '^]}$' | grep -ve '"recycling:shoes":"yes"' | ./sanitize_json_jq.sh > ./osm_varios/brno_container_no_shoes.geojson
echo '#!/bin/bash' > ./osm_varios/brno_container_no_shoes_JOSM.sh
cat ./osm_varios/brno_container.json | ./urlize.sh | grep -e '"recycling:clothes":"yes"' -e 'FeatureCollection' -e '^]}$' | grep -ve '"recycling:shoes":"yes"' | ./josmize.sh >> ./osm_varios/brno_container_no_shoes_JOSM.sh

echo "Brno recycling shoes without clothes"
cat ./osm_varios/brno_container.json | ./urlize.sh | grep -e '"recycling:shoes":"yes"' -e 'FeatureCollection' -e '^]}$' | grep -ve '"recycling:clothes":"yes"' | ./sanitize_json_jq.sh > ./osm_varios/brno_container_no_clothes.geojson
echo '#!/bin/bash' > ./osm_varios/brno_container_no_clothes_JOSM.sh
cat ./osm_varios/brno_container.json | ./urlize.sh | grep -e '"recycling:shoes":"yes"' -e 'FeatureCollection' -e '^]}$' | grep -ve '"recycling:clothes":"yes"' | ./josmize.sh >> ./osm_varios/brno_container_no_clothes_JOSM.sh

echo "Brno steps count"
osmium tags-filter ./brno-latest.osm.pbf nwr/highway=steps --overwrite -o ./osm_varios/brno_steps.pbf
osmium export ./osm_varios/brno_steps.pbf --overwrite -o ./osm_varios/brno_steps.json -c ./osmium_options.json
cat ./osm_varios/brno_steps.json | ./urlize.sh | grep -e '"highway":"steps"' -e 'FeatureCollection' -e '^]}$' | grep -e '"step_count"' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./osm_varios/brno_steps.geojson
## jq example cat ./osm_varios/brno_steps.geojson | jq '.features[] | select(.properties."step_count" == "47")'
cat ./osm_varios/brno_steps.geojson | jq '.features |=  sort_by(.properties.step_count | tonumber)' > ./osm_varios/brno_steps_sorted.geojson
