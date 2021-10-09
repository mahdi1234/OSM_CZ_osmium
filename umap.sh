#!/bin/bash
# get latest country file
wget http://download.geofabrik.de/europe/czech-republic-latest.osm.pbf

# export ecycling_type=centre without recycling: details
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/recycling_type=centre -o recycling_centre.pbf
osmium export recycling_centre.pbf --overwrite -o recycling_centre.json
cat recycling_centre.geojson | grep -i '"recycling_type":"centre"' | grep -vi "recycling:" > undefined_recycling_centre.geojson

## annotate all geojson files
sed -i '1 i\\{"type":"FeatureCollection","features":[' *.geojson
sed -i '$a ]}' *.geojson
rm ./czech-republic-latest.osm.pbf
