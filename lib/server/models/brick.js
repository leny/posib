"use strict";
var Brick, config, root;

root = "" + __dirname + "/..";

config = require("" + root + "/core/config.js");

module.exports = Brick = (function() {
  var _getBrickType;

  function Brick() {}

  Brick.prototype.TYPE_SHORT = "short";

  Brick.prototype.TYPE_RICH = "rich";

  Brick.prototype.TYPE_MAP = "map";

  Brick.prototype.TYPE_FORM = "form";

  Brick.prototype.TYPE_IMAGE = "image";

  Brick.prototype.TYPE_LIST = "list";

  Brick.prototype.TYPE_AUDIO = "audio";

  Brick.prototype.TYPE_VIDEO = "video";

  Brick.prototype.TYPE_TIME = "time";

  Brick.prototype.TYPE_FILE = "file";

  Brick.prototype.TYPE_ARTICLE = "article";

  Brick.prototype.TYPE_LINK = "link";

  Brick.prototype.TYPE_TABLE = "table";

  Brick.factory = function($node, fNext) {
    var sTagName;
    sTagName = $node["0"].name;
    return fNext(null, null);
  };

  _getBrickType = function(sTagName) {
    switch (sTagName.toLowerCase()) {
      case "h1":
      case "h2":
      case "h3":
      case "h4":
      case "h5":
      case "h6":
      case "span":
      case "em":
      case "strong":
      case "small":
      case "b":
      case "u":
      case "i":
      case "del":
      case "figcaption":
        return false;
      case "p":
        return false;
      case "img":
        return false;
      case "address":
        return false;
      case "form":
        return false;
      case "ol":
      case "ul":
        return false;
      case "audio":
        return false;
      case "video":
        return false;
      case "time":
        return false;
      case "article":
        return false;
      case "a":
        return false;
      case "table":
        return false;
      default:
        return false;
    }
  };

  return Brick;

})();
