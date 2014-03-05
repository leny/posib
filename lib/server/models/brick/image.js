
/*
 * posib.
 * http://posib.krkn.be
 *
 * server/models/brick/image.js
 * ImageBrick class.
 *
 * coded by leny @ krkn
 * started at 04/02/14
 */

/*
    ImageBrick class
    ----------------
    A ImageBrick is an editable image tag.
    The following tags are ImageBrick : img
    If an image tag has dimensions, they are saved and will be used for resizing when the user uploads an image.
 */
"use strict";
var Brick, ImageBrick, config, root,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

root = "" + __dirname + "/../..";

config = require("" + root + "/core/config.js");

Brick = require("" + root + "/models/brick.js");

module.exports = ImageBrick = (function(_super) {
  __extends(ImageBrick, _super);

  function ImageBrick() {
    return ImageBrick.__super__.constructor.apply(this, arguments);
  }

  ImageBrick.prototype._create = function() {
    var iHeight, iWidth;
    return {
      src: this.node.attr("src"),
      alt: this.node.attr("alt"),
      width: isNaN(iWidth = +this.node.attr("width")) ? false : iWidth,
      height: isNaN(iHeight = +this.node.attr("height")) ? false : iHeight
    };
  };

  ImageBrick.prototype._render = function() {
    var iHeight, iWidth;
    this.node.attr("src", this.get("src"));
    this.node.attr("alt", this.get("alt"));
    if ((iWidth = this.get("width"))) {
      this.node.attr("width", iWidth);
    }
    if ((iHeight = this.get("height"))) {
      return this.node.attr("height", iHeight);
    }
  };

  return ImageBrick;

})(Brick);
