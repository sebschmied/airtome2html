<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes"/>

    <xsl:variable name="minimumDistance">1000</xsl:variable>
    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>

        <html>
            <head>
                <meta charset="UTF-8"/>
                <style>
                    table{
                        width: 100%;
                        margin: 20px 0;
                        border-collapse: collapse;
                        border-top: 1px solid #ddd;
                        border-left: 1px solid #ddd;
                    }
                    table .heading{
                        background: #666;
                        color: #fff;
                        text-transform: uppercase;
                        text-align: center;
                    }
                    table th,
                    table td{
                        border-bottom: 1px solid #ddd;
                        border-right: 1px solid #ddd;
                        padding-left: 1em;
                        padding-right: 1em;
                        padding-top: 0.5em;
                        padding-bottom: 0.2em;
                    }
                    table th{
                        font-weight: bold;
                    }
                    table tr:nth-of-type(even){
                        background: #eee;
                    }
                    table .hover{
                        background: #ccc;
                    }
                    
                    .number,
                    .date,
                    .duration,
                    .distance
                    {
                        text-align: right;
                    }
                    
                    .comment
                    {
                        width: 20%;
                    }
                    
                    p.full-comment{
                        font-style: italic;
                    }
                    
                    #map{
                        position: fixed;
                        top: 2em;
                        left: 2em;
                        
                        width: 500px;
                        height: 500px;
                        display: none;
                    }</style>
                <script src="jquery-3.3.1.min.js"/>
            </head>
            <body>
                <h2>Flugbuch</h2>
                <div id="map">Karte</div>
                <table>
                    <tr>
                        <th>Flug</th>

                        <th>Datum</th>
                        <th>Schirm</th>
                        <th>Fluggebiet</th>
                        <th>Dauer</th>
                        <th>Strecke</th>
                        <th>Kommentar</th>
                        <th/>
                    </tr>
                    <xsl:for-each select="JFlightlistArray/list/JFlight">
                        <xsl:sort select="position()" data-type="number" order="descending"/>
                        <tr>
                            <xsl:attribute name="id">
                                <xsl:value-of select="number"/>
                            </xsl:attribute>
                            <!-- # -->
                            <td class="number">
                                <xsl:value-of select="number"/>
                            </td>



                            <!-- Datum -->

                            <td class="date">

                                <xsl:choose>
                                    <xsl:when test="date/new">
                                        <xsl:value-of select="date/new/@day"/>.<xsl:value-of
                                            select="date/new/@month"/>.<xsl:value-of
                                            select="date/new/@year"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="date/org/@day"/>.<xsl:value-of
                                            select="date/org/@month"/>.<xsl:value-of
                                            select="date/org/@year"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>
                            <!-- -->
                            <td class="glider">
                                <xsl:choose>
                                    <xsl:when test="glidertyp/@new">
                                        <xsl:value-of select="glidertyp/@new"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="glidertyp/@org"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>

                            <!-- Fluggebiet -->
                            <td class="site">
                                <xsl:choose>
                                    <xsl:when test="site/@new">
                                        <xsl:value-of select="site/@new"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="site/@org"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="country/text()">
                                    <xsl:text> / </xsl:text>
                                    <xsl:value-of select="country"/>
                                </xsl:if>
                            </td>



                            <!-- Dauer -->
                            <td class="duration">
                                <xsl:choose>
                                    <xsl:when test="duration/new">
                                        <xsl:if test="duration/new/@hour &gt; 0">
                                            <xsl:value-of select="duration/new/@hour"/>h </xsl:if>
                                        <xsl:value-of select="duration/new/@minute"/>m </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:if test="duration/org/@hour &gt; 0">
                                            <xsl:value-of select="duration/org/@hour"/>h </xsl:if>
                                        <xsl:value-of select="duration/org/@minute"/>m
                                    </xsl:otherwise>
                                </xsl:choose>
                            </td>

                            <!-- Strecke -->
                            <td class="distance">


                                <xsl:choose>
                                    <xsl:when
                                        test="olc/FlightDistance/int[1] &gt; 10000 or olc/FlightDistance/int[2] &gt; 10000 or olc/FlightDistance/int[3] &gt; 10000">
                                        <xsl:value-of
                                            select="round(max(olc/FlightDistance/*) div 1000)"/> km
                                    </xsl:when>
                                </xsl:choose>


                            </td>
                            <!-- Kommentar -->
                            <td class="comment">
                                <xsl:if test="comment/text()">
                                    <xsl:choose>
                                        <xsl:when test="string-length(comment) &gt; 30">

                                            <details>
                                                <summary>
                                                  <xsl:value-of select="substring(comment, 1, 30)"/>
                                                  <xsl:if test="string-length(comment) &gt; 30">
                                                  [...] </xsl:if>

                                                </summary>
                                                <p class="full-comment">
                                                  <xsl:value-of select="comment"/>
                                                </p>
                                            </details>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="comment"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:if>
                            </td>
                            <!-- Karte -->

                            <td>
                                <button>
                                    <xsl:attribute name="value">flightbook/<xsl:value-of
                                            select="number"/>/<xsl:value-of select="ICGfile"
                                        />.kml</xsl:attribute>
                                    <xsl:attribute name="class">showmap</xsl:attribute>
                                    <xsl:attribute name="id">
                                        <xsl:text>showmap-</xsl:text>
                                        <xsl:value-of select="number"/>
                                    </xsl:attribute>
                                    <xsl:text>Karte</xsl:text>
                                </button>
                            </td>
                        </tr>

                    </xsl:for-each>
                </table>

                <script async="async" defer="defer" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB1CqtckRTi90FYDLfUjuUIydnPzoJzmiI&amp;callback=initMap">
                    
                </script>

                <script>
                    var map;
                    var mapelem = document.getElementById('map');
                    var src;
                    
                    
                    function initMap(src, mapelem) {
                        
                        
                        map = new google.maps.Map(mapelem, {
                            center: new google.maps.LatLng(-19.257753, 146.823688),
                            mapTypeId: 'terrain',
                            zoom: 2
                        });
                        
                        var kmlLayer = new google.maps.KmlLayer(src, {
                            suppressInfoWindows: true,
                            preserveViewport: false,
                            map: map
                        });
                        
                        kmlLayer.addListener('click', function(event) {
                            var content = event.featureData.infoWindowHtml;
                            var testimonial = document.getElementById('capture');
                            testimonial.innerHTML = content;
                        });
                        }
                    
                    
                    $(document).ready(function(){
                     /* Hier der jQuery-Code */
                     $('.showmap').click(function(){
                        src=$(this).val();
                        mapelem.style.display = "block";
                        initMap(src, mapelem);
                         
                         
                     });
                    });
                </script>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
