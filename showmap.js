var map;
var layer;
var mapelem = document.getElementById('google-maps-view-of-track');
var mapcontainer = document.getElementById('maps-container');


var src = kmzbaseurl+ "flightbook/530/2018-01-01_11_08_56.igc.kmz"; //maps api needs a dummy kmz for initializing

function initialize() {
    var hash = location.hash;
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
    
    if (hash.match(/^#flight\-[0-9]*$/g))
        selectFlight($(hash));
    
    
}

function selectFlight(elem) {
    
    var activeclass = "tr-active";
    $('.tr-showmap').not(elem).removeClass(activeclass);
    elem.addClass(activeclass);
    kmlurl = kmzbaseurl + "/" + elem.data("kmz");
    if (kmlurl.includes("/blob/") && kmlurl.includes("github.com")) //do we use github binaries?
            kmlurl += "?raw=true";
    layer.setUrl(kmlurl);
    layer.setMap(map);
    elem[0].scrollIntoView(true);
    
}
$(document).ready(function() {
    $('.tr-showmap').click(function() {
        selectFlight($(this));
    });
});
