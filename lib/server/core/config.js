
/*
 * posib.
 * http://posib.krkn.be
 *
 * server/core/config.js
 * Singleton Class to store configuration in-memory.
 *
 * coded by leny @ krkn
 * started at 02/02/14
 */
"use strict";
var Config, oConfigInstance, path, _;

_ = require("lodash");

path = require("path");

oConfigInstance = null;

Config = (function() {
  var _basePath, _oCurrentConfigValues, _oDefaultConfigValues;

  _oDefaultConfigValues = {
    production: true,
    port: 22000,
    path: ".",
    contents: "./contents",
    home: "index.html"
  };

  _oCurrentConfigValues = {};

  _basePath = path.dirname(require.main.filename);

  function Config(oGivenConfig) {
    if (oGivenConfig == null) {
      oGivenConfig = {};
    }
    _oCurrentConfigValues = _.extend(_oDefaultConfigValues, oGivenConfig);
    this.port = _oCurrentConfigValues.port;
    this.path = path.resolve(_basePath, _oCurrentConfigValues.path);
    this.contents = path.resolve(_basePath, _oCurrentConfigValues.contents);
    this.home = _oCurrentConfigValues.home;
    this.production = _oCurrentConfigValues.production;
  }

  return Config;

})();

exports.init = function(oConfig) {
  return oConfigInstance = new Config(oConfig);
};

exports.get = function() {
  if (!oConfigInstance) {
    console.error("Config must be initiated before use !");
  }
  return oConfigInstance;
};
