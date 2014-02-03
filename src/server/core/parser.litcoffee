# [posib.](http://posib.krkn.be)

## **/server/core/parser.js** - *Parser class*

coded by leny @ krkn

started at 03/02/14

* * *

Document parsing class.

* * *

    "use strict"

    root = "#{ __dirname }/.."

    cheerio = require "cheerio"
    fs = require "fs"
    Q = require "q"

    config = require "#{ root }/core/config.js"

    Brick = require "#{ root }/models/brick.js"

    module.exports = class Parser
        _sUrl = null
        _sPath = null
        _sRawContent = null
        _$ = null

### Parser( sUrl )

        constructor: ( sUrl ) ->
            _sUrl = sUrl
            _sPath = config.get().path + _sUrl

### display( fNext )

        display: ( fNext ) ->
            # TODO get from cache
            # TODO load content
            # TODO parse bricks
            # TODO fill page infos
            # TODO write in cache
            # TODO returns content as text
            Q
                .fcall _load
                .then _parseBricks
                .fail ( oError ) ->
                    fNext oError
                .done ->
                    fNext()

#### _load

        _load = ->
            deferred = Q.defer()
            readOptions =
                encoding: "utf-8"
            fs.readFile _sPath, readOptions, ( oError, sRawContent ) ->
                deferred.reject oError if oError
                _sRawContent = sRawContent
                _$ = cheerio.load sRawContent,
                    xmlMode: yes
                    normalizeWhitespace: yes
                deferred.resolve()
            deferred.promise

#### _parseBricks

        _parseBricks = ->
            deferred = Q.defer()
            $bricks = _$( "body *[data-posib-ref]" )
            iParsedBricks = 0
            $bricks.each ->
                console.log "brick:", _$( @ ).attr( "data-posib-ref" )
                Brick.factory _$( @ ), ( oError, oBrick ) ->
                    console.log oError, oBrick
                    # TODO check error
                    # TODO call oBrick.render()
                    deferred.resolve() if ++iParsedBricks is $bricks.length
            deferred.promise
