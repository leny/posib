# [http://posib.krkn.be](posib.)

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

Setting up an express router app.

    app = express()

Configure some default middlewares

    app.use express.json()
    app.use express.urlencoded()
    app.use express.cookieParser()

Configure static middleware(s)

> TODO

Configure logging middleware

    app.use middlewares.log

Load controllers

    require( "#{ root }/controllers/public.js" ).init app

Define the router

    app.use app.router

    module.exports = app
