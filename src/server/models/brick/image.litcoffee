# [posib.](http://posib.krkn.be)

## **/server/models/brick/image.js** - *ImageBrick class*

coded by leny @ krkn

started at 04/02/14

* * *

ImageBrick class.

A *ImageBrick* is an editable image tag.

The following tags are ImageBrick : `img`

If an image tag has dimensions, they are saved and will be used for resizing when the user uploads an image.

* * *

    "use strict"

    root = "#{ __dirname }/../.."

    config = require "#{ root }/core/config.js"

    Brick = require "#{ root }/models/brick.js"

    module.exports = class ImageBrick extends Brick

### _create()

        _create: ->
            src: @node.attr "src"
            alt: @node.attr "alt"
            width: if isNaN( iWidth = +@node.attr( "width" ) ) then no else iWidth
            height: if isNaN( iHeight = +@node.attr( "height" ) ) then no else iHeight

### _render()

        _render: ->
            @node.attr "src", @get "src"
            @node.attr "alt", @get "alt"
            @node.attr "width", iWidth if ( iWidth = @get "width" )
            @node.attr "height", iHeight if ( iHeight = @get "height" )

