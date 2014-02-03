# [posib.](http://posib.krkn.be)

## **/server/core/router.js** - *Router initalisation*

coded by leny @ krkn

started at 02/02/14

* * *

Config & setup of the **expressjs** router.

* * *

    "use strict"

    root = "#{ __dirname }/.."

    express = require "express"

    middlewares = require "#{ root }/core/router/middlewares.js"

### init( port, staticPath )

Setting up an express router app.

    exports.init = ( iPort, sStaticPath ) ->
        app = express()

Configure some default middlewares

        app.use express.json()
        app.use express.urlencoded()
        app.use express.cookieParser()

Configure logging middleware

        app.use middlewares.log

Load controllers

        require( "#{ root }/controllers/public.js" ).init app

Configure the router

        app.use app.router

Configure static middleware(s)

        app.use express.static sStaticPath

Listen the requests

        app.listen iPort

        app
