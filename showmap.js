var map;
var layer;
var mapelem = document.getElementById('google-maps-view-of-track');
var mapcontainer = document.getElementById('maps-container');


var src = kmzbaseurl+ "flightbook/530/2018-01-01_11_08_56.igc.kmz"; //maps api needs a dummy kmz for initializing

function initialize() {
    mapelem = document.getElementById("google-maps-view-of-track");
    map = new google.maps.Map(mapelem, {
        center: new google.maps.LatLng(lat, long),
        mapTypeId: 'terrain',
        zoom: 10
    });
    layer = new google.maps.KmlLayer(src, {
        suppressInfoWindows: true,
        preserveViewport: false,
        url: src, //dummy
        map: map
    });
}
$(document).ready(function() {
    $('.tr-showmap').click(function() {
        $('.tr-showmap').not(this).removeClass("tr-active");
        $(this).addClass("tr-active");
        kmlurl = kmzbaseurl + "/" + $(this).data("kmz");
        if (kmlurl.includes("/blob/") && kmlurl.includes("github.com")) //do we use github binaries?
            kmlurl += "?raw=true";
        layer.setUrl(kmlurl);
        layer.setMap(map);
    });
});
