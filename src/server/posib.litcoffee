# [posib.](http://posib.krkn.be)

## **/server/posib.js** - *Main entry point*

coded by leny @ krkn

started at 02/02/14

* * *

**posib.** is basicaly a simple *static* web server, that parse html files and fill specific tags with informations filled by the user.

* * *

    "use strict"

    root = __dirname

    Pandri = require "pandri"

    config = require "#{ root }/core/config.js"
    router = require "#{ root }/core/router.js"

    exports.start = ( oConfig ) ->
        config.init oConfig

        store = new Pandri "data"
        store.load config.get().contents + "/data.json", ->
            router.init config.get().port, config.get().path
