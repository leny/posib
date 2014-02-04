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

  ShortBrick.prototype.render = function() {
    return ShortBrick.__super__.render.call(this);
  };

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
