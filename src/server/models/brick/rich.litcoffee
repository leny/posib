# [posib.](http://posib.krkn.be)

## **/server/models/brick/rich.js** - *RichBrick class*

coded by leny @ krkn

started at 04/02/14

* * *

RichBrick class.

A *RichBrick* is an editable text block tag.

The following tags are RichBricks : `p`

An unique RichBricks can represent subsequent `p` tags.

* * *

    "use strict"

    root = "#{ __dirname }/../.."

    cheerio = require "cheerio"

    config = require "#{ root }/core/config.js"

    Brick = require "#{ root }/models/brick.js"

    module.exports = class RichBrick extends Brick

### _create()

        _create: ->
            content: if @node.html().trim() then "<p>#{ @node.html().trim() }</p>" else "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>"

### _render()

        _render: ->
            oAttributes = @node.attr()
            ( @nodes = cheerio @get "content" ).each ->
                for sAttribute, sValue of oAttributes
                    cheerio( @ ).attr sAttribute, sValue
            @node.replaceWith @nodes

### _clean()

As the *RichBrick* class can rely multiple nodes, the default Brick._clean() method isnt adapted.

        _clean: ->
            @nodes.each ->
                cheerio( @ ).removeAttr "data-posib-ref"
