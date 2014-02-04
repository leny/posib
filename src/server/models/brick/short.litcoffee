# [posib.](http://posib.krkn.be)

## **/server/models/brick/short.js** - *ShortBrick class*

coded by leny @ krkn

started at 03/02/14

* * *

ShortBrick class.

A *ShortBrick* is an editable inline-text tag.

The following tags are ShortBricks : `h1`, `h2`, `h3`, `h4`, `h5`, `h6`, `span`, `em`, `strong`, `small`, `b`, `u`, `i`, `del`, `figcaption`.

* * *

    "use strict"

    root = "#{ __dirname }/../.."

    config = require "#{ root }/core/config.js"

    Brick = require "#{ root }/models/brick.js"

    module.exports = class ShortBrick extends Brick

### _create()

        _create: ->
            content: @node.text().trim() or "Lorem ipsum..."

### _render()

        _render: ->
            @node.text @get "content"

