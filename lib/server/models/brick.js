"use strict";
var Brick, Pandri, config, root;

root = "" + __dirname + "/..";

Pandri = require("pandri");

config = require("" + root + "/core/config.js");

module.exports = Brick = (function() {
  var _getBrickType;

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

  function Brick($node) {
    this.node = $node;
    this.reference = $node.attr("data-posib-ref");
    this._load();
  }

  Brick.prototype.get = function(sKey) {
    return this.data[sKey];
  };

  Brick.prototype.render = function() {
    this._render();
    return this._clean();
  };

  Brick.prototype._load = function() {
    var oData;
    this.store = Pandri.get("data");
    oData = this.store.get(this.reference);
    this.isNew = !oData;
    this.data = oData != null ? oData : this._create();
    if (this.isNew) {
      return this._save();
    }
  };

  Brick.prototype._save = function(fNext) {
    this.store.set(this.reference, this.data);
    return this.store.save(fNext);
  };

  Brick.prototype._clean = function() {
    return this.node.removeAttr("data-posib-ref");
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
        return Brick.prototype.TYPE_SHORT;
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

  Brick.factory = function($node, fNext) {
    var ShortBrick, sTagName;
    sTagName = $node["0"].name;
    switch (_getBrickType(sTagName)) {
      case Brick.prototype.TYPE_SHORT:
        ShortBrick = require("" + root + "/models/brick/short.js");
        return fNext(null, new ShortBrick($node));
      default:
        return fNext(new Error("This tag has no Brick Type associated !"));
    }
  };

  return Brick;

})();
