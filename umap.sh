#!/bin/bash
wget http://download.geofabrik.de/europe/czech-republic-latest.osm.pbf
osmium tags-filter ./czech-republic-latest.osm.pbf nwr/recycling_type=centre -o recycling_centre.pbf
osmium export recycling_centre.pbf -o recycling_centre.geojson
echo '{"type":"FeatureCollection","features":[' > undefined_recycling_centre.geojson
cat recycling_centre.geojson | grep -i '"recycling_type":"centre"' | grep -vi "recycling:" >> undefined_recycling_centre.geojson
echo ']}' >> undefined_recycling_centre.geojson
rm ./czech-republic-latest.osm.pbf
