#!/bin/bash
source airtome2html.config.sh
if [ "${copytooutputdirectory}" = true ]; then
    set -e
    rsync -aq --progress ${PWD}/flightbook ${outputdir}
    cp -f ${PWD}/flightbook.css ${outputdir}
    cp -f ${PWD}/showmap.js ${outputdir}
    cp -f ${PWD}/${jqueryfile} ${outputdir}
    cp -f ${PWD}/github.png ${outputdir}
    echo "${outputdir} synced."
    set +e
else
    echo "Content is available in ${PWD}/index.html and ${PWD}/flightbook/."
fi
