# [http://posib.krkn.be](posib.)

## **/server/controllers/public.js** - *Public controller*

coded by leny @ krkn

started at 02/02/14

* * *

The **public** controller maps the public routes, showing the parsed files of the site.

* * *

    "use strict"

    root = "#{ __dirname }/.."

    config = require "#{ root }/core/config.js"

### [GET] /

Redirect to home page.
Using the config values, we redirect to the homepage.

    homepage = ( oRequest, oResponse ) ->

> TODO : redirect to the homepage

        oResponse.send "hey, this is the homepage, no ?"

* * *

Declare routes

    exports.init = ( oApp ) ->
        oApp.get "/", homepage
