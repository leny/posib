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
    Page = require "#{ root }/models/page.js"

    module.exports = class Parser
        _sUrl = null
        _sPath = null
        _sRawContent = null
        _$ = null
        _sResultingContent = null

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
            # TODO parse links
            # TODO generate content
            # TODO write in cache
            # TODO returns content as text
            Q
                .fcall _load
                .then _parseBricks
                .then _pageInfos
                .then _generateCode
                .fail ( oError ) ->
                    fNext oError
                .done ->
                    fNext null, _sResultingContent

#### _load

        _load = ->
            deferred = Q.defer()
            readOptions =
                encoding: "utf-8"
            fs.readFile _sPath, readOptions, ( oError, sRawContent ) ->
                if oError
                    oError.type = 404
                    oError.message = "404 - Not Found"
                    deferred.reject oError
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
                Brick.factory _$( @ ), ( oError, oBrick ) ->
                    # TODO check error
                    oBrick.render() if oBrick
                    deferred.resolve() if ++iParsedBricks is $bricks.length
                    return
                return
            deferred.promise

#### _pageInfos

        _pageInfos = ->
            $head = _$( "head" )
            oPage = new Page _sUrl, $head
            oPage.render()

#### _generateCode

Export the current DOM content as text.

        _generateCode = ->
            _sResultingContent = _$.html()
