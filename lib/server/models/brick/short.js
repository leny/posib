
/*
 * posib.
 * http://posib.krkn.be
 *
 * server/models/brick/rich.js
 * RichBrick class.
 *
 * coded by leny @ krkn
 * started at 04/02/14
 */

/*
    ShortBrick class
    ----------------
    A ShortBrick is an editable inline-text tag.
    The following tags are ShortBricks : h1, h2, h3, h4, h5, h6, span, em, strong, small, b, u, i, del, figcaption.
 */
"use strict";
var Brick, ShortBrick, config, root,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

root = "" + __dirname + "/../..";

config = require("" + root + "/core/config.js");

Brick = require("" + root + "/models/brick.js");

module.exports = ShortBrick = (function(_super) {
  __extends(ShortBrick, _super);

  function ShortBrick() {
    return ShortBrick.__super__.constructor.apply(this, arguments);
  }

  ShortBrick.prototype._create = function() {
    return {
      content: this.node.text().trim() || "Lorem ipsum..."
    };
  };

  ShortBrick.prototype._render = function() {
    return this.node.text(this.get("content"));
  };

  return ShortBrick;

})(Brick);
