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

### Brick.factory( $node, fNext )

        @factory = ( $node, fNext ) ->
            sTagName = $node[ "0" ].name
            fNext null, null

        _getBrickType = ( sTagName ) ->
            switch sTagName.toLowerCase()
                when "h1", "h2", "h3", "h4", "h5", "h6", "span", "em", "strong", "small", "b", "u", "i", "del", "figcaption"
                    no # TODO Brick::TYPE_SHORT
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
