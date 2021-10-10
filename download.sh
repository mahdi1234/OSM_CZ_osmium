#!/bin/bash
wget -O extract.pbf http://download.geofabrik.de/europe/czech-republic-latest.osm.pbf
osmium extract -p cezch_republic.geojson extract.pbf --overwrite -o czech-republic-latest.osm.pbf
