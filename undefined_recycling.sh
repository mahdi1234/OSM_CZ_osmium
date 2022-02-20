#!/bin/bash

mkdir -p undefined_recycling

echo "Recycling centre"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/recycling_type=centre --overwrite -o undefined_recycling/recycling_centre.pbf
osmium export undefined_recycling/recycling_centre.pbf --overwrite -o undefined_recycling/recycling_centre_temp.json -c osmium_options.json
cat ./undefined_recycling/recycling_centre_temp.json | ./urlize.sh | grep -vi 'LineString' > ./undefined_recycling/recycling_centre.json
cat ./undefined_recycling/recycling_centre.json | grep -e '"recycling_type":"centre"' -e 'FeatureCollection' -e '^]}$' | grep -vi "recycling:" | ./sanitize_json_jq.sh > ./undefined_recycling/undefined_recycling_centre.geojson

echo "Recycling container"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/recycling_type=container --overwrite -o undefined_recycling/recycling_container.pbf
osmium export undefined_recycling/recycling_container.pbf --overwrite -o undefined_recycling/recycling_container_temp.json -c osmium_options.json
cat ./undefined_recycling/recycling_container_temp.json | ./urlize.sh | grep -vi 'LineString' > ./undefined_recycling/recycling_container.json
cat ./undefined_recycling/recycling_container.json | grep -e '"recycling_type":"container"' -e 'FeatureCollection' -e '^]}$' | grep -vi "recycling:" | ./sanitize_json_jq.sh > ./undefined_recycling/undefined_recycling_container.geojson

echo "Recycling no type"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/amenity=recycling --overwrite -o undefined_recycling/recycling_no_type.pbf
osmium export undefined_recycling/recycling_no_type.pbf --overwrite -o undefined_recycling/recycling_no_type_temp.json -c osmium_options.json
cat ./undefined_recycling/recycling_no_type_temp.json | ./urlize.sh | grep -vi 'LineString' > ./undefined_recycling/recycling_no_type.json
cat ./undefined_recycling/recycling_no_type.json | grep -e '"amenity":"recycling"' -e 'FeatureCollection' -e '^]}$' | grep -vi "recycling_type" | ./sanitize_json_jq.sh > ./undefined_recycling/recycling_no_type.geojson
echo '#!/bin/bash' > ./undefined_recycling/recycling_no_type_JOSM.sh
cat ./undefined_recycling/recycling_no_type.json | grep -e '"amenity":"recycling"' | grep -vi "recycling_type" | ./josmize.sh >> ./undefined_recycling/recycling_no_type_JOSM.sh

echo "Recycling: with no amenity or recycling_type"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/recycling:* --overwrite -o undefined_recycling/recycling_type_no_amenity.pbf
osmium export undefined_recycling/recycling_type_no_amenity.pbf --overwrite -o undefined_recycling/recycling_type_no_amenity_temp.json -c osmium_options.json
cat ./undefined_recycling/recycling_type_no_amenity_temp.json | ./urlize.sh | grep -vi 'LineString' > ./undefined_recycling/recycling_type_no_amenity.json
cat ./undefined_recycling/recycling_type_no_amenity.json | grep -e '"recycling:' -e 'FeatureCollection' -e '^]}$' | grep -vi "recycling_type"  | grep -vi '"amenity":"recycling"' | ./sanitize_json_jq.sh > ./undefined_recycling/recycling_type_no_amenity.geojson

echo "Dump progress stats"
> ./undefined_recycling/progress.txt
echo "Sberna strediska" >> ./undefined_recycling/progress.txt
cat ./undefined_recycling/undefined_recycling_centre.geojson | grep 'centre' | wc -l >> ./undefined_recycling/progress.txt
echo "Kontejnery" >> ./undefined_recycling/progress.txt
cat ./undefined_recycling/undefined_recycling_container.geojson | grep 'container' | wc -l >> ./undefined_recycling/progress.txt
echo "Bez typu" >> ./undefined_recycling/progress.txt
cat ./undefined_recycling/recycling_no_type.geojson | grep 'amenity' | wc -l >> ./undefined_recycling/progress.txt
echo "recycling:* bez amenity + bez recycling_type" >> ./undefined_recycling/progress.txt
cat ./undefined_recycling/recycling_type_no_amenity.geojson | grep '"Feature"' | wc -l >> ./undefined_recycling/progress.txt

echo "Create gpx"
mkdir -p undefined_recycling/gpx
gpsbabel -i geojson -f ./undefined_recycling/undefined_recycling_centre.geojson -o gpx -F ./undefined_recycling/gpx/undefined_recycling_centre.gpx
gpsbabel -i geojson -f ./undefined_recycling/undefined_recycling_container.geojson -o gpx -F ./undefined_recycling/gpx/undefined_recycling_container.gpx
gpsbabel -i geojson -f ./undefined_recycling/recycling_no_type.geojson -o gpx -F ./undefined_recycling/gpx/recycling_no_type.gpx
gpsbabel -i geojson -f ./undefined_recycling/recycling_type_no_amenity.geojson -o gpx -F ./undefined_recycling/gpx/recycling_known_without_amenity_type.gpx
sed -i '/.*time.*/d' ./undefined_recycling/gpx/*.gpx
