# Airtome
flightbookfilename="flugbuch" # Your flightbook's file name, without the .fb.zip part
airtomebin="/Applications/AirTome/AirTome.app" # Your AirTome executable

# Website

copytooutputdirectory=true # Copy output website files to a local directory, e.g. /var/www/html/ (outputdir, see below)
outputdir="${HOME}/git/sebschmied.github.io/flights" # The local path to store your website at, if copytooutputdirectory is set to true. If false, the script's working directory will be used instead.
websiteroot="https://sebschmied.github.io" # The website you're publishing on
kmzroot="https://github.com/sebschmied/sebschmied.github.io/blob/master/flights" # Root folder used for the .kmz files. In this case, I use the github tree instead of the github.io proxy, because there are some syncing issues. Set to "" (empty string) if the kmz directory doesn't differ from your website.
websitetitle="Flugbuch" # The big h2 headline and title tag
googlemapsapikey="AIzaSyB1CqtckRTi90FYDLfUjuUIydnPzoJzmiI" # Get your api key here: https://developers.google.com/maps/documentation/javascript/get-api-key
minimum_xc_distance="15000" # Minimum xc distance in meters to display the distance at all. This is because I don't care about the distance for local soaring etc. Set to 0 if you do.



## Column titles
columntitle_number="Flug"
columntitle_date="Datum"
columntitle_aircraft="Schirm"
columntitle_distance="Strecke"
columntitle_site="Fluggebiet"
columntitle_duration="Dauer"
columntitle_comment="Kommentar"

# Maps
maps_line_color="ee0000ff"  #The line color to use for your track
maps_line_width="4"         # The line width 
maps_points_count="22000"   # Maximum number of track points. 22000 is enough to fully cover a 6 hour flight in 1.1 MB (igc + kmz), reduce this if disk space is an issue.
latitude="48.764444" # initial position of map before any flight is selected
longitude="8.280556" # Probably use your home site or something.

# Pilot data

### Dont't edit below this line unless you know what you do ###

jqueryfile="jquery-3.3.1.min.js"

# no special kmz root
if [ "${kmzroot}" == "" ]; then
    kmzroot=${websiteroot}
fi

# no special output dir
if [ "${outputdir}" == "" ]; then
    outputdir=${PWD}
fi

# Set saxon executable (differs on mac)
if command -v saxonb-xslt > /dev/null; then
    saxoncommand=$(which saxonb-xslt)
else
    if command -v saxon > /dev/null; then
        saxoncommand=$(which saxon)
    else
        echo "No XSLT processor found. Please install saxon."
        exit 1
    fi
fi

# If airtomebin doesn't work, try where it would be on mac os
if [ ! -f ${airtomebin} ]; then
    if [ -d /Applications/AirTome.app ]; then
        airtomebin="open /Applications/AirTome/AirTome.app"
    else
        echo "Please set the airtomebin path in airtome2html.config.sh"
    fi
fi

