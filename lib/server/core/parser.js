"use strict";
var Brick, Parser, Q, cheerio, config, fs, root;

root = "" + __dirname + "/..";

cheerio = require("cheerio");

fs = require("fs");

Q = require("q");

config = require("" + root + "/core/config.js");

Brick = require("" + root + "/models/brick.js");

module.exports = Parser = (function() {
  var _$, _generateCode, _load, _parseBricks, _sPath, _sRawContent, _sResultingContent, _sUrl;

  _sUrl = null;

  _sPath = null;

  _sRawContent = null;

  _$ = null;

  _sResultingContent = null;

  _sResultingContent = "unparsed";

  function Parser(sUrl) {
    _sUrl = sUrl;
    _sPath = config.get().path + _sUrl;
  }

  Parser.prototype.display = function(fNext) {
    return Q.fcall(_load).then(_parseBricks).then(_generateCode).fail(function(oError) {
      return fNext(oError);
    }).done(function() {
      return fNext(null, _sResultingContent);
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
    var $bricks, deferred, iParsedBricks;
    deferred = Q.defer();
    $bricks = _$("body *[data-posib-ref]");
    iParsedBricks = 0;
    $bricks.each(function() {
      Brick.factory(_$(this), function(oError, oBrick) {
        if (oBrick) {
          oBrick.render();
        }
        if (++iParsedBricks === $bricks.length) {
          deferred.resolve();
        }
      });
    });
    return deferred.promise;
  };

  _generateCode = function() {
    return _sResultingContent = _$.html();
  };

  return Parser;

})();
