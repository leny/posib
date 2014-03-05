###
 * posib.
 * http://posib.krkn.be
 *
 * server/models/page.js
 * Page class.
 *
 * coded by leny @ krkn
 * started at 03/02/14
###

###
    Page class
    ----------
    A Page is a class representing the page and manipulating the head tag, filling title and meta tags.
###

"use strict"

root = "#{ __dirname }/.."

Pandri = require "pandri"

cheerio = require "cheerio"

config = require "#{ root }/core/config.js"

module.exports = class Page

    # Page( sURL, $head )
    constructor: ( sURL, $head ) ->
        @head = $head
        @reference = "__page__#{ sURL }"
        @_load()

    # get( sKey )
    # Getter for page data.
    get: ( sKey ) ->
        @data[ sKey ]

    # render()
    render: ->
        @head.find( "title" ).text @get "title"
        @_addMetaTag "keywords", @get "keywords"
        @_addMetaTag "description", @get "description"
        @_addMetaTag "robots", @get "robots"

    # _load()
    # Load the current brick infos from the Pandri data store.
    # If the Pandri store has no data for the current Brick, the _create method is called.
    # This method returns the base data for the current Brick type.
    _load: ->
        @store = Pandri.get "data"
        oData = @store.get @reference
        @isNew = !oData
        @data = oData ? @_create()
        @_save() if @isNew

    # _save()
    # Save the current data in the Pandri data store.
    _save: ( fNext ) ->
        @store.set @reference, @data
        @store.save fNext

    # _create()
    # Clean the node for content display, removing useless attribute.
    _create: ->
        title: ( @head.find( "title" ).text() or "titre de la page" ).trim()
        keywords: ( @head.find( "meta[name=\"keywords\"]" ).attr( "content" ) or "" ).trim() or no
        description: ( @head.find( "meta[name=\"description\"]" ).attr( "content" ) or "" ).trim() or no
        robots: ( @head.find( "meta[name=\"robots\"]" ).attr( "content" ) or "" ).trim() or no

    # _addMetaTag( sName, sValue )
    # Generate a meta tag.
    _addMetaTag: ( sName, sValue ) ->
        return unless sValue
        if ( $meta = @head.find "meta[name=\"#{ sName }\"]" ).length is 0
            ( $meta = cheerio( "<meta />" ) )
                .attr "name", sName
                @head.append $meta
        $meta.attr "content", sValue
