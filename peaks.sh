#!/bin/bash

mkdir -p peaks

echo "General ele tag"
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/ele=* --overwrite -o ./peaks/peaks.pbf
osmium export ./peaks/peaks.pbf --overwrite -o ./peaks/peaks.json -c ./osmium_options.json
cat ./peaks/peaks.json | ./urlize.sh | grep -e '"ele":' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./peaks/peaks.geojson

echo "over 1000m"
cat ./peaks/peaks.json | ./urlize.sh |  grep -e '"ele":"1[[:digit:]][[:digit:]][[:digit:]]"' -e '"ele":"1[[:digit:]][[:digit:]][[:digit:]]\.[[:digit:]]' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./peaks/peaks_1000.geojson

echo "over 900m"
cat ./peaks/peaks.json | ./urlize.sh |  grep -e '"ele":"9[[:digit:]][[:digit:]]"' -e '"ele":"9[[:digit:]][[:digit:]]\.[[:digit:]]' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./peaks/peaks_900.geojson

echo "over 800m"
cat ./peaks/peaks.json | ./urlize.sh |  grep -e '"ele":"8[[:digit:]][[:digit:]]"' -e '"ele":"8[[:digit:]][[:digit:]]\.[[:digit:]]' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./peaks/peaks_800.geojson

echo "over 700m"
cat ./peaks/peaks.json | ./urlize.sh |  grep -e '"ele":"7[[:digit:]][[:digit:]]"' -e '"ele":"7[[:digit:]][[:digit:]]\.[[:digit:]]' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./peaks/peaks_700.geojson

echo "over 600m"
cat ./peaks/peaks.json | ./urlize.sh |  grep -e '"ele":"6[[:digit:]][[:digit:]]"' -e '"ele":"6[[:digit:]][[:digit:]]\.[[:digit:]]' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./peaks/peaks_600.geojson

echo "over 500m"
cat ./peaks/peaks.json | ./urlize.sh |  grep -e '"ele":"5[[:digit:]][[:digit:]]"' -e '"ele":"5[[:digit:]][[:digit:]]\.[[:digit:]]' -e 'FeatureCollection' -e '^]}$' | ./sanitize_json_jq.sh > ./peaks/peaks_500.geojson
