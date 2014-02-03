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

### Brick.factory( $node, fNext )

        @factory = ( $node, fNext ) ->
            sTagName = $node[ "0" ].name
            fNext null, null
