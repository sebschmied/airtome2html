## airtome viewer

This is essentially a web export for flightbooks created with airtome, see https://airtome.bitbucket.io/

Output: https://sebschmied.github.io/

### Components:
#### ./get: 
git pull the repository and create a .fb.zip that can be opened and edited by airtome.

#### ./push
* Extract the .fb.zip (simply because git doesn't like binaries), 
* Run ./igc2kmz to loop through ./flightbook to create .kmz files from .igc files where not yet done. 
* Use saxon/xslt to create an index.html from the flugbuch.xml, using the flightbook.xslt stylesheet
* git add, commit and push everything that has changed

### How to use
Most is hardcoded, so you need to edit quite a bit. Sorry. This manual assumes debian or ubuntu, and bash.

* Get all the tools you need:
```bash
sudo apt update
sudo apt install git gpsbabel libsaxonb-java
```
* Fork or whatever and clone
* Remove my flights ``rm -r index.html ./flightbook``.
* copy your own .fb.zip into the project's root folder.
* If your flight book is not called flugbuch.fb.zip (haha), grep / sed everything to match your own, or wait until I un-hardcode that
* Change the google maps api key in flighbook.xsl to your own (please). See https://developers.google.com/maps/documentation/javascript/get-api-key to get one. It's free for personal use.
* Also in flightbook.xsl, change the minimumDistance variable to your own definition of an xc flight, or set it to 0 to display the distance for all flights.
* In showmap.js, change the kmzbaseurl value to match your own repo, and the center value in initialize() to match your local site.
* Change the last line in ./get to match your own Airtome binary path, or just remove that line if you prefer to open it yourself.
* Run ./push to populate github. The first run will take quite a while, because .kmz files are created. You can now use the directory as a htdocs folder on your own webserver, or use github pages as I did.
* Run ./get. From now on, always run ./get to make any changes.
* In airtome, open the .fb.zip manually if this is the first run. Make some changes and close.
* Run ./push to publish changes. Don't commit/push manually, because this would ignore any changes in the .fb.zip.

