"use strict";
var Parser, Q, cheerio, config, fs, root;

root = "" + __dirname + "/..";

cheerio = require("cheerio");

fs = require("fs");

Q = require("q");

config = require("" + root + "/core/config.js");

module.exports = Parser = (function() {
  var _$, _load, _parseBricks, _sPath, _sRawContent, _sUrl;

  _sUrl = null;

  _sPath = null;

  _sRawContent = null;

  _$ = null;

  function Parser(sUrl) {
    _sUrl = sUrl;
    _sPath = config.get().path + _sUrl;
  }

  Parser.prototype.display = function(fNext) {
    return Q.fcall(_load).then(_parseBricks).fail(function(oError) {
      return fNext(oError);
    }).done(function() {
      return fNext();
    });
  };

  _load = function() {
    var deferred, readOptions;
    deferred = Q.defer();
    readOptions = {
      encoding: "utf-8"
    };
    fs.readFile(_sPath, readOptions, function(oError, sRawContent) {
      if (oError) {
        deferred.reject(oError);
      }
      _sRawContent = sRawContent;
      _$ = cheerio.load(sRawContent, {
        xmlMode: true,
        normalizeWhitespace: true
      });
      return deferred.resolve();
    });
    return deferred.promise;
  };

  _parseBricks = function() {
    var iParsedBricks, oBricks;
    oBricks = _$("[data-posib-ref]");
    iParsedBricks = 0;
    return oBricks.each(function() {
      return console.log("brick:", _$(this).attr("data-posib-ref"));
    });
  };

  return Parser;

})();
