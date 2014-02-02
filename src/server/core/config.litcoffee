# [posib.](http://posib.krkn.be)

## **/server/core/config.js** - *Configuration Class*

coded by leny @ krkn

started at 02/02/14

* * *

Singleton Class to store configuration in-memory.

* * *

    "use strict"

    _ = require "lodash"
    path = require "path"

    oConfigInstance = null

    class Config
        _oDefaultConfigValues =
            port: 22000
            path: "."
            contents: "./contents"
            home: "index.html"

        _oCurrentConfigValues = {}

        _basePath = path.dirname require.main.filename

        constructor: ( oGivenConfig = {} ) ->
            _oCurrentConfigValues = _.extend _oDefaultConfigValues, oGivenConfig

            @port = _oCurrentConfigValues.port
            @path = path.resolve _basePath, _oCurrentConfigValues.path
            @contents = path.resolve _basePath, _oCurrentConfigValues.contents
            @home = _oCurrentConfigValues.home

    exports.init = ( oConfig ) ->
        oConfigInstance = new Config oConfig

    exports.get = ->
        console.error "Config must be initiated before use !" if not oConfigInstance
        oConfigInstance
