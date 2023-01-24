#!/bin/bash
wget -O extract.pbf http://download.geofabrik.de/europe/czech-republic-latest.osm.pbf
osmium extract -p czech_republic.geojson extract.pbf --overwrite -o czech-republic-latest.osm.pbf
osmium extract -p brno.geojson extract.pbf --overwrite -o brno-latest.osm.pbf
