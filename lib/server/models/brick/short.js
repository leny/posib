"use strict";
var Brick, ShortBrick, config, root,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

root = "" + __dirname + "/../..";

config = require("" + root + "/core/config.js");

Brick = require("" + root + "/models/brick.js");

module.exports = ShortBrick = (function(_super) {
  __extends(ShortBrick, _super);

  function ShortBrick($node) {
    console.log("ShortBrick");
  }

  return ShortBrick;

})(Brick);
