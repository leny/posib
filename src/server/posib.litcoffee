# [http://posib.krkn.be](posib.)

## **/server/posib.js** - *Main entry point*

coded by leny @ krkn

started at 02/02/14

* * *

**posib.** is basicaly a simple *static* web server, that parse html files and fill specific tags with informations filled by the user.

* * *

    "use strict"

    root = __dirname

    config = require "#{ root }/core/config.js"
    router = require "#{ root }/core/router.js"

    exports.start = ( oConfig ) ->
        config.init oConfig
        router.listen config.get().port
