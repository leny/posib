# [http://posib.krkn.be](posib.)

## **/server/core/config.js** - *Configuration Class*

coded by leny @ krkn

started at 02/02/14

* * *

Singleton Class to store configuration in-memory.

* * *

    "use strict"

    _ = require "lodash"

    oConfigInstance = null

    class Config
        _oDefaultConfigValues =
            port: 22000
            contents: "./contents"
            home: "index.html"

        _oCurrentConfigValues = {}

        constructor: ( oGivenConfig = {} ) ->
            _oCurrentConfigValues = _.extend _oDefaultConfigValues, oGivenConfig

            @port = _oCurrentConfigValues.port
            @contents = _oCurrentConfigValues.contents
            @home = _oCurrentConfigValues.home

    exports.init = ( oConfig ) ->
        oConfigInstance = new Config oConfig

    exports.get = ->
        console.error "Config must be initiated before use !" if not oConfigInstance
        oConfigInstance
