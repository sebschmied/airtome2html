## airtome viewer

This is essentially a web export for flight books created with airtome, see https://airtome.bitbucket.io/

Sample Output: https://sebschmied.github.io/flights

### Components:

#### flightbook.xsl
An XSLT stylesheet that translates parts of the airtome xml format to fancy html.

#### ./get: 
* Git pull the repository and create a .fb.zip that can be opened and edited by airtome.
* Open airtome
* * Run ``sync-wwwdir.sh`` in case anything has changed in the .fb.zip.

#### ./push
* Extract the .fb.zip (simply because git doesn't like binaries), 
* Run ``./igc2kmz``
* Run ``transform.sh``
* Run ``sync-wwwdir.sh``
* git add, commit and push everything that has changed

#### ./transform
* Populate the stylesheet with the values set in ``airtome2html.config`` and transform it to an index.html file.

#### ./sync-wwwdir.sh
* Copy files to an output directory, if activated in ``airtome2html.config``. This one is probably called more often then necessary because I let rsync decide whether something needs to be updated.

#### ./igc2kmz
*  Loop through ``./flightbook/**`` to create .kmz files from .igc files where not yet done. This will also replace any spaces in .igc file names.

### How to use
Assuming debian or ubuntu and bash:

* Get all the tools you need:
```bash
sudo apt update
sudo apt install git gpsbabel libsaxonb-java
```
* Fork or whatever and clone
* Remove my flights ``rm -r index.html ./flightbook``.
* copy your own .fb.zip into the project's root folder.
* Edit ``airtome2html.config``, see comments there.
* Run ./push to populate github and/or your output directory. The first run will take quite a while, because .kmz files are created.
* Run ./get. From now on, always run ./get to make any changes.
* In airtome, open the .fb.zip manually if this is the first run. Make some changes and close.
* Run ./push to publish changes. Don't commit/push manually if flight data is involved, because this would .gitignore any changes in the .fb.zip.

