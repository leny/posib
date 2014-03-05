
/*
 * posib.
 * http://posib.krkn.be
 *
 * server/models/page.js
 * Page class.
 *
 * coded by leny @ krkn
 * started at 03/02/14
 */

/*
    Page class
    ----------
    A Page is a class representing the page and manipulating the head tag, filling title and meta tags.
 */
"use strict";
var Page, Pandri, cheerio, config, root;

root = "" + __dirname + "/..";

Pandri = require("pandri");

cheerio = require("cheerio");

config = require("" + root + "/core/config.js");

module.exports = Page = (function() {
  function Page(sURL, $head) {
    this.head = $head;
    this.reference = "__page__" + sURL;
    this._load();
  }

  Page.prototype.get = function(sKey) {
    return this.data[sKey];
  };

  Page.prototype.render = function() {
    this.head.find("title").text(this.get("title"));
    this._addMetaTag("keywords", this.get("keywords"));
    this._addMetaTag("description", this.get("description"));
    return this._addMetaTag("robots", this.get("robots"));
  };

  Page.prototype._load = function() {
    var oData;
    this.store = Pandri.get("data");
    oData = this.store.get(this.reference);
    this.isNew = !oData;
    this.data = oData != null ? oData : this._create();
    if (this.isNew) {
      return this._save();
    }
  };

  Page.prototype._save = function(fNext) {
    this.store.set(this.reference, this.data);
    return this.store.save(fNext);
  };

  Page.prototype._create = function() {
    return {
      title: (this.head.find("title").text() || "titre de la page").trim(),
      keywords: (this.head.find("meta[name=\"keywords\"]").attr("content") || "").trim() || false,
      description: (this.head.find("meta[name=\"description\"]").attr("content") || "").trim() || false,
      robots: (this.head.find("meta[name=\"robots\"]").attr("content") || "").trim() || false
    };
  };

  Page.prototype._addMetaTag = function(sName, sValue) {
    var $meta;
    if (!sValue) {
      return;
    }
    if (($meta = this.head.find("meta[name=\"" + sName + "\"]")).length === 0) {
      ($meta = cheerio("<meta />")).attr("name", sName);
      this.head.append($meta);
    }
    return $meta.attr("content", sValue);
  };

  return Page;

})();
