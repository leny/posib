# [posib.](http://posib.krkn.be)

## **/server/controllers/public.js** - *Public controller*

coded by leny @ krkn

started at 02/02/14

* * *

The **public** controller maps the public routes, showing the parsed files of the site.

* * *

    "use strict"

    root = "#{ __dirname }/.."

    config = require "#{ root }/core/config.js"
    Parser = require "#{ root }/core/parser.js"

### [GET] /

Redirect to home page.
Using the config values, redirect to the homepage.

    homepage = ( oRequest, oResponse ) ->
        oResponse.redirect config.get().home

### [GET] `/\/.+\.html?/i` (*/page.html*)

Serve a page.
From the file path, calling the parser who will return the parsed page from cache if exists.

    page = ( oRequest, oResponse ) ->
        page = new Parser oRequest.url
        page.display ( oError, sContent ) ->

> TODO check error

            oResponse.send sContent

* * *

Declare routes

    exports.init = ( oApp ) ->
        oApp.get "/", homepage
        oApp.get /\/.+\.html?/i, page
