###
 * posib.
 * http://posib.krkn.be
 *
 * server/posib.js
 * Main entry point
 *
 * posib. is basicaly a simple static web server, that parse html files and fill specific tags with informations filled by the user.
 *
 * coded by leny @ krkn
 * started at 02/02/14
###

"use strict"

root = __dirname

Pandri = require "pandri"

config = require "#{ root }/core/config.js"
router = require "#{ root }/core/router.js"

exports.start = ( oConfig ) ->
    config.init oConfig

    if not config.get().production
        Pandri.clear "data"
        Pandri.clear "cache"

    bDataIsLoaded = no
    bCacheIsLoaded = no

    ( new Pandri "data" )
        .load "#{ config.get().contents }/data.json", ->
            bDataIsLoaded = yes
            router.init config.get().port, config.get().path if bDataIsLoaded and bCacheIsLoaded

    ( new Pandri "cache" )
        .load "#{ config.get().contents }/cache.json", ->
            bCacheIsLoaded = yes
            router.init config.get().port, config.get().path if bDataIsLoaded and bCacheIsLoaded
