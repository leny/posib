"use strict";
var Brick, Page, Pandri, Parser, Q, cheerio, client, config, fs, root, swig;

root = "" + __dirname + "/..";

client = "" + root + "/../client/templates";

cheerio = require("cheerio");

fs = require("fs");

Q = require("q");

Pandri = require("pandri");

swig = require("swig");

config = require("" + root + "/core/config.js");

Brick = require("" + root + "/models/brick.js");

Page = require("" + root + "/models/page.js");

module.exports = Parser = (function() {
  var _$, _addConnectElements, _generateCode, _load, _oCacheStore, _pageInfos, _parseBricks, _sPath, _sRawContent, _sResultingContent, _sUrl, _writeInCache;

  _sUrl = null;

  _sPath = null;

  _sRawContent = null;

  _$ = null;

  _sResultingContent = null;

  _oCacheStore = null;

  function Parser(sUrl) {
    _sUrl = sUrl;
    _sPath = config.get().path + _sUrl;
    _oCacheStore = Pandri.get("cache");
  }

  Parser.prototype.display = function(fNext) {
    var _sCachedContent;
    if (_sCachedContent = _oCacheStore.get(_sUrl)) {
      return fNext(null, _sCachedContent);
    }
    return Q.fcall(_load).then(_parseBricks).then(_pageInfos).then(_generateCode).then(_writeInCache).fail(function(oError) {
      return fNext(oError);
    }).done(function() {
      return fNext(null, _sResultingContent);
    });
  };

  Parser.prototype.showConnect = function(fNext) {
    return Q.fcall(_load).then(_parseBricks).then(_pageInfos).then(_addConnectElements).then(_generateCode).fail(function(oError) {
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
        oError.type = 404;
        oError.message = "404 - Not Found";
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

  _pageInfos = function() {
    var $head, oPage;
    $head = _$("head");
    oPage = new Page(_sUrl, $head);
    return oPage.render();
  };

  _generateCode = function() {
    return _sResultingContent = _$.html();
  };

  _writeInCache = function() {
    _oCacheStore.set(_sUrl, _sResultingContent);
    return _oCacheStore.save();
  };

  _addConnectElements = function() {
    var $modal, $posib, $script, $stylesheet;
    ($stylesheet = cheerio("<link />")).attr("rel", "stylesheet").attr("href", "/__posib/styles/admin.css");
    _$("head").append($stylesheet);
    $modal = cheerio(swig.renderFile("" + client + "/modals/connect.html", {}));
    ($posib = cheerio("<div />")).attr("id", "posib").append($modal);
    ($script = cheerio("<script />")).attr("src", "/__posib/js/connect.js");
    return _$("body").append($posib).append($script);
  };

  return Parser;

})();
