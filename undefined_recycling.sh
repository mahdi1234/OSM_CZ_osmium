#!/bin/bash
mkdir -p undefined_recycling
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/recycling_type=centre --overwrite -o undefined_recycling/recycling_centre.pbf
osmium export undefined_recycling/recycling_centre.pbf --overwrite -o undefined_recycling/recycling_centre.json
cat undefined_recycling/recycling_centre.json | grep -i '"recycling_type":"centre"' | grep -vi "recycling:" > undefined_recycling/undefined_recycling_centre.geojson
sed -i '1 i\\{"type":"FeatureCollection","features":[' ./undefined_recycling/*.geojson
sed -i '$a ]}' undefined_recycling/*.geojson
