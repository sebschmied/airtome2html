#!/bin/bash

source airtome2html.config
tmpfile="/tmp/flightbook.xsl"
cp $PWD/flightbook.xsl ${tmpfile}
declare -a params=(
"flightbookfilename"
"airtomebin"
"websiteroot" 
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
   rpl -qf "var_${i}" "${!i}" $tmpfile > /dev/null 2>&1 #I gave up on sed because of escaping problem
done

saxonb-xslt ${flightbookfilename}.xml ${tmpfile} > index.html
