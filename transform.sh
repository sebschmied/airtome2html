#!/bin/bash

source airtome2html.config
tmpfile="/tmp/flightbook.xsl"
cp $PWD/flightbook.xsl ${tmpfile}
declare -a params=(
"flightbookfilename"
"airtomebin"
"websiteroot" 
"kmzroot"
"websitetitle"
"googlemapsapikey"
"columntitle_number" 
"columntitle_date"
"columntitle_aircraft"
"columntitle_site" 
"columntitle_duration"
"columntitle_distance"
"columntitle_comment" 
"maps_line_color"
"maps_line_width"
"maps_points_count"
"minimum_xc_distance"
"latitude"
"longitude"
)

for i in "${params[@]}"
do
   sed -i.bak "s|var_${i}|${!i}|g" $tmpfile
done

saxonb-xslt ${flightbookfilename}.xml ${tmpfile} > index.html
