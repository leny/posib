"use strict";
var Brick, config, root;

root = "" + __dirname + "/..";

config = require("" + root + "/core/config.js");

module.exports = Brick = (function() {
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

  Brick.factory = function($node, fNext) {
    var sTagName;
    sTagName = $node["0"].name;
    return fNext(null, null);
  };

  return Brick;

})();
