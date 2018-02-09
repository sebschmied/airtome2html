## airtome viewer

This is essentially a web export for flight books created with airtome, see https://airtome.bitbucket.io/

Output: https://sebschmied.github.io/

### Components:

#### flightbook.xsl
An XSLT stylesheet that translates parts of the airtome xml format to fancy html.

#### ./get: 
git pull the repository and create a .fb.zip that can be opened and edited by airtome.

#### ./push
* Extract the .fb.zip (simply because git doesn't like binaries), 
* Run ``./igc2kmz``
* Run ``transform.sh``
* git add, commit and push everything that has changed

#### ./transform
* Populate the stylesheet with the values set in ``airtome2html.config`` and transform it to index.html

#### ./igc2kmz
*  Loop through ``./flightbook/**`` to create .kmz files from .igc files where not yet done. This will also replace any spaces in .igc file names.

### How to use
Assuming debian or ubuntu and bash:

* Get all the tools you need:
```bash
sudo apt update
sudo apt install git gpsbabel libsaxonb-java rpl
```
* Fork or whatever and clone
* Remove my flights ``rm -r index.html ./flightbook``.
* copy your own .fb.zip into the project's root folder.
* Edit ``airtome2html.config``, see comments there.
* Run ./push to populate github. The first run will take quite a while, because .kmz files are created. You can now use the directory as a htdocs folder on your own webserver, or use github pages as I did.
* Run ./get. From now on, always run ./get to make any changes.
* In airtome, open the .fb.zip manually if this is the first run. Make some changes and close.
* Run ./push to publish changes. Don't commit/push manually, because this would ignore any changes in the .fb.zip.

