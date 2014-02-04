# [posib.](http://posib.krkn.be)

## **/server/models/brick.js** - *Brick parent class*

coded by leny @ krkn

started at 03/02/14

* * *

Brick parent class.

A *Brick* is an editable tag.

* * *

    "use strict"

    root = "#{ __dirname }/.."

    Pandri = require "pandri"

    config = require "#{ root }/core/config.js"

    module.exports = class Brick

Available types

        TYPE_SHORT: "short"
        TYPE_RICH: "rich"
        TYPE_MAP: "map"
        TYPE_FORM: "form"
        TYPE_IMAGE: "image"
        TYPE_LIST: "list"
        TYPE_AUDIO: "audio"
        TYPE_VIDEO: "video"
        TYPE_TIME: "time"
        TYPE_FILE: "file"
        TYPE_ARTICLE: "article"
        TYPE_LINK: "link"
        TYPE_TABLE: "table"

### Brick( $node )

Brick is an abstract class. The constructor is called from inherited classes.

        constructor: ( $node ) ->
            @node = $node
            @reference = $node.attr "data-posib-ref"
            @_load()

### get( sKey )

        get: ( sKey ) ->
            @data[ sKey ]

### render()

        render: ->
            @_render()
            @_clean()

### _load()

Load the current brick infos from the *Pandri* data store.
If the *Pandri* store has no data for the current Brick, the `_create` method is called.
This method returns the base data for the current Brick type.

        _load: ->
            @store = Pandri.get "data"
            oData = @store.get @reference
            @isNew = !oData
            @data = oData ? @_create()
            @_save() if @isNew

### _save()

Save the current data in the *Pandri* data store.

        _save: ( fNext ) ->
            @store.set @reference, @data
            @store.save fNext

### _clean()

        _clean: ->
            @node.removeAttr "data-posib-ref"

#### _getBrickType( sTagName )

        _getBrickType = ( sTagName ) ->
            switch sTagName.toLowerCase()
                when "h1", "h2", "h3", "h4", "h5", "h6", "span", "em", "strong", "small", "b", "u", "i", "del", "figcaption"
                    Brick::TYPE_SHORT
                when "p"
                    no # TODO Brick::TYPE_RICH
                when "img"
                    no # TODO Brick::TYPE_IMAGE
                when "address"
                    no # TODO Brick::TYPE_MAP
                when "form"
                    no # TODO Brick::TYPE_FORM
                when "ol", "ul"
                    no # TODO Brick::TYPE_LIST
                when "audio"
                    no # TODO Brick::TYPE_AUDIO
                when "video"
                    no # TODO Brick::TYPE_VIDEO
                when "time"
                    no # TODO Brick::TYPE_TIME
                when "article"
                    no # TODO Brick::TYPE_ARTICLE
                when "a"
                    no # TODO Brick::TYPE_LINK
                when "table"
                    no # TODO Brick::TYPE_TABLE
                else
                    no

### Brick.factory( $node, fNext )

        @factory = ( $node, fNext ) ->
            sTagName = $node[ "0" ].name
            switch _getBrickType sTagName
                when Brick::TYPE_SHORT
                    ShortBrick = require "#{ root }/models/brick/short.js"
                    fNext null, new ShortBrick $node
                else
                    fNext new Error "This tag has no Brick Type associated !"

