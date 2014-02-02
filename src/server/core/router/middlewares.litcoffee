# [http://posib.krkn.be](posib.)

## **/server/core/router/middlewares.js** - *Router middlewares*

coded by leny @ krkn

started at 02/02/14

* * *

The **expressjs** router will need some middlewares with posib.

* * *

    "use strict"

    root = "#{ __dirname }/../.."

    utils = require "#{ root }/core/utils.js"

### log

Log middleware : immediate logging in console.

    exports.log = ( oRequest, oResponse, fNext ) ->
        utils.log "(#{ oRequest.method }) #{ oRequest.url }", "router"
        fNext()
