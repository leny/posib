###
 * posib.
 * http://posib.krkn.be
 *
 * server/core/parser.js
 * Document parsing class.
 *
 * coded by leny @ krkn
 * started at 03/02/14
###

"use strict"

root = "#{ __dirname }/.."
client = "#{ root }/../client/templates"

cheerio = require "cheerio"
fs = require "fs"
Q = require "q"
Pandri = require "pandri"
swig = require "swig"

config = require "#{ root }/core/config.js"

Brick = require "#{ root }/models/brick.js"
Page = require "#{ root }/models/page.js"

module.exports = class Parser

    _sUrl = null
    _sPath = null
    _sRawContent = null
    _$ = null
    _sResultingContent = null
    _oCacheStore = null

    # Parser( sUrl )
    constructor: ( sUrl ) ->
        _sUrl = sUrl
        _sPath = config.get().path + _sUrl
        _oCacheStore = Pandri.get "cache"

    # display( fNext )
    display: ( fNext ) ->
        return fNext null, _sCachedContent if _sCachedContent = _oCacheStore.get _sUrl
        Q
            .fcall _load
            .then _parseBricks
            .then _pageInfos
            .then _generateCode
            .then _writeInCache
            .fail ( oError ) ->
                fNext oError
            .done -> fNext null, _sResultingContent

    # showConnect( fNext )
    showConnect: ( fNext ) ->
        Q
            .fcall _load
            .then _parseBricks
            .then _pageInfos
            .then _addConnectElements
            .then _generateCode
            .fail ( oError ) ->
                fNext oError
            .done -> fNext null, _sResultingContent

    # _load
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

    # _parseBricks
    _parseBricks = ->
        deferred = Q.defer()
        $bricks = _$( "body *[data-posib-ref]" )
        iParsedBricks = 0
        $bricks.each ->
            Brick.factory _$( this ), ( oError, oBrick ) ->
                # TODO check error
                oBrick.render() if oBrick
                deferred.resolve() if ++iParsedBricks is $bricks.length
                return
            return
        deferred.promise

    # _pageInfos
    _pageInfos = ->
        $head = _$( "head" )
        oPage = new Page _sUrl, $head
        oPage.render()

    # _generateCode
    # Export the current DOM content as text.
    _generateCode = ->
        _sResultingContent = _$.html()

    # _writeInCache
    _writeInCache = ->
        _oCacheStore.set _sUrl, _sResultingContent
        _oCacheStore.save()

    # _addConnectElements
    _addConnectElements = ->
        # Add admin stylesheet.
        ( $stylesheet = cheerio "<link />" )
            .attr "rel", "stylesheet"
            .attr "href", "/__posib/styles/admin.css"
        _$( "head" )
            .append $stylesheet

        # Add modal html code.
        $modal = cheerio swig.renderFile "#{ client }/modals/connect.html", {}
        ( $posib = cheerio "<div />"  )
            .attr "id", "posib"
            .append $modal

        # Add `script` tag for connect box.
        ( $script = cheerio "<script />"  )
            .attr "src", "/__posib/js/connect.js"
        _$( "body" )
            .append $posib
            .append $script
