<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="utf-8" indent="yes"/>
    <xsl:variable name="minimumDistance">15000</xsl:variable> <!-- Minimum distance to display a flight's xc distance. In meters -->
    <xsl:variable name="google-maps-api-key">AIzaSyB1CqtckRTi90FYDLfUjuUIydnPzoJzmiI</xsl:variable>
    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;&#xa;</xsl:text>
        <html>
            <head>
                
                <meta charset="UTF-8"/>
                <meta name="robots" content="noindex"/>
                <link rel="stylesheet" type="text/css" href="flightbook.css"/>
                <title>Flugbuch</title>
            </head>
            <body>
                <script><xsl:attribute name="src"><xsl:text>jquery-3.3.1.min.js</xsl:text></xsl:attribute></script>
                <script>
                    <xsl:attribute name="async">async</xsl:attribute>
                    <xsl:attribute name="defer">defer</xsl:attribute>
                    <xsl:attribute name="src">https://maps.googleapis.com/maps/api/js?key=<xsl:value-of select="$google-maps-api-key" />&amp;callback=initialize</xsl:attribute>
                    
                </script>
                <script src="showmap.js"/>
                <h2>Flugbuch</h2>
                
                    <a href="https://github.com/sebschmied/sebschmied.github.io"><img id="forkmeongithub" src="https://camo.githubusercontent.com/a6677b08c955af8400f44c6298f40e7d19cc5b2d/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f677261795f3664366436642e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_gray_6d6d6d.png" /></a>
               
                <div>
                    <div id="maps-container">
                        <div id="google-maps-view-of-track"/>
                    </div>
                    <div id="flightbook-table">
                        <table>
                            <tr>
                                <th>Flug</th>
                                <th>Datum</th>
                                <th>Schirm</th>
                                <th>Fluggebiet</th>
                                <th>Dauer</th>
                                <th>Strecke</th>
                                <th>Kommentar</th>
                            </tr>
                            <xsl:for-each select="JFlightlistArray/list/JFlight">
                                <xsl:sort select="position()" data-type="number" order="descending"/>
                                <tr>
                                    <xsl:if test="ICGfile/text()">

                                        <xsl:attribute name="data-kmz">flightbook/<xsl:value-of
                                                select="number"/>/<xsl:value-of select="ICGfile"
                                            />.kmz</xsl:attribute>
                                        <xsl:attribute name="class">tr-showmap</xsl:attribute>
                                    </xsl:if>
                                    <xsl:attribute name="id">
                                        <xsl:text>flight-</xsl:text>
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
                                    <!-- Schirm -->
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
                                                test="round(max(olc/FlightDistance/*)) &gt; $minimumDistance">
                                                <xsl:value-of
                                                  select="round(max(olc/FlightDistance/*) div 1000)"
                                                /> km </xsl:when>
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
                                </tr>
                            </xsl:for-each>
                        </table>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
