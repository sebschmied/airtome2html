#!/bin/bash
source $PWD/airtome2html.config
cat << EOF > ./parameters.xml

# Pass params to the stylesheet
<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template name="params">
        <xsl:param name="websiteroot">${websiteroot}</xsl:param>
        <xsl:param name="websitetitle">${websitetitle}</xsl:param>
        <xsl:param name="googlemapsapikey">${googlemapsapikey}</xsl:param>
        <xsl:param name="columntitle_number">${columntitle_number}</xsl:param>
        <xsl:param name="columntitle_date">${columntitle_date}</xsl:param>
        <xsl:param name="columntitle_aircraft">${columntitle_aircraft}</xsl:param>
        <xsl:param name="columntitle_site">${columntitle_site}</xsl:param>
        <xsl:param name="columntitle_duration">${columntitle_duration}</xsl:param>
        <xsl:param name="columntitle_comment">${columntitle_comment}</xsl:param>
        <xsl:param name="minimum_xc_distance">${minimum_xc_distance}</xsl:param>    
    </xsl:template>
</xsl:stylesheet>
EOF

saxonb-xslt ${flightbookfilename}.xml flightbook.xsl > index.html
