
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
    RichBrick class
    ---------------
    A RichBrick is an editable text block tag.
    The following tags are RichBricks : p
    An unique RichBricks can represent subsequent p tags.
 */
"use strict";
var Brick, RichBrick, cheerio, config, root,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

root = "" + __dirname + "/../..";

cheerio = require("cheerio");

config = require("" + root + "/core/config.js");

Brick = require("" + root + "/models/brick.js");

module.exports = RichBrick = (function(_super) {
  __extends(RichBrick, _super);

  function RichBrick() {
    return RichBrick.__super__.constructor.apply(this, arguments);
  }

  RichBrick.prototype._create = function() {
    return {
      content: this.node.html().trim() ? "<p>" + (this.node.html().trim()) + "</p>" : "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>"
    };
  };

  RichBrick.prototype._render = function() {
    var oAttributes;
    oAttributes = this.node.attr();
    (this.nodes = cheerio(this.get("content"))).each(function() {
      var sAttribute, sValue, _results;
      _results = [];
      for (sAttribute in oAttributes) {
        sValue = oAttributes[sAttribute];
        _results.push(cheerio(this).attr(sAttribute, sValue));
      }
      return _results;
    });
    return this.node.replaceWith(this.nodes);
  };

  RichBrick.prototype._clean = function() {
    return this.nodes.each(function() {
      return cheerio(this).removeAttr("data-posib-ref");
    });
  };

  return RichBrick;

})(Brick);
