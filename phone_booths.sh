#!/bin/bash

mkdir -p phone_booths

echo "Active phone booths"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/*=telephone --overwrite -o ./phone_booths/all_phone_booths.pbf
osmium export ./phone_booths/all_phone_booths.pbf --overwrite -o ./phone_booths/all_phone_booths_temp.json -c osmium_options.json
cat ./phone_booths/all_phone_booths_temp.json | grep -vi 'LineString' > ./phone_booths/all_phone_booths.json
cat ./phone_booths/all_phone_booths.json | grep -e '"amenity":"telephone"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./phone_booths/active_phone_booths.geojson

echo "Disused phone booths"
cat ./phone_booths/all_phone_booths.json | grep -e '"disused:amenity":"telephone"' -e '"historic:amenity":"telephone"' -e 'FeatureCollection' -e '^]}$' | grep -vi "check_date" | grep -vi "survey_date" | tac | sed '2s/,$//' | tac | jq . > ./phone_booths/disused_phone_booths.geojson

echo "Verified phone booths"
cat ./phone_booths/all_phone_booths.json | grep -e '"survey:date"' -e '"check_date"' -e 'FeatureCollection' -e '^]}$' | tac | sed '2s/,$//' | tac | jq . > ./phone_booths/verified_phone_booths.geojson

echo "Dump progress stats"
> ./phone_booths/progress.txt
echo "Telefonni budky" >> ./phone_booths/progress.txt
active=$(cat ./phone_booths/active_phone_booths.geojson | grep -e '"telephone"' | wc -l)
echo $active >> ./phone_booths/progress.txt
echo "disused: Telefonni budky" >> ./phone_booths/progress.txt
disused=$(cat ./phone_booths/disused_phone_booths.geojson | grep -e '"telephone"' | wc -l)
echo $disused >> ./phone_booths/progress.txt
echo "Overeny Telefonni budky" >> ./phone_booths/progress.txt
checked=$(cat ./phone_booths/verified_phone_booths.geojson | grep -e '"telephone"' | wc -l)
echo $checked >> ./phone_booths/progress.txt
total=$(( $active + $disused + $checked))
echo "Celkem - $total" >> ./phone_booths/progress.txt

echo "Create gpx"
mkdir -p phone_booths/gpx
gpsbabel -i geojson -f ./phone_booths/active_phone_booths.geojson -o gpx -F ./phone_booths/gpx/active_phone_booths.gpx
gpsbabel -i geojson -f ./phone_booths/disused_phone_booths.geojson -o gpx -F ./phone_booths/gpx/disused_phone_booths.gpx
gpsbabel -i geojson -f ./phone_booths/verified_phone_booths.geojson -o gpx -F ./phone_booths/gpx/verified_phone_booths.gpx
gpsbabel -i geojson -f ./phone_booths/active_phone_booths.geojson -f ./phone_booths/disused_phone_booths.geojson -o gpx -F ./phone_booths/gpx/for_verification.gpx
sed -i '/.*time.*/d' phone_booths/gpx/*.gpx
