var Config, oConfigInstance, _;

_ = require("lodash");

oConfigInstance = null;

Config = (function() {
  var _oCurrentConfigValues, _oDefaultConfigValues;

  _oDefaultConfigValues = {
    port: 22000,
    contents: "./contents",
    home: "index.html"
  };

  _oCurrentConfigValues = {};

  function Config(oGivenConfig) {
    if (oGivenConfig == null) {
      oGivenConfig = {};
    }
    _oCurrentConfigValues = _.extend(_oDefaultConfigValues, oGivenConfig);
    this.port = _oCurrentConfigValues.port;
    this.contents = _oCurrentConfigValues.contents;
    this.home = _oCurrentConfigValues.home;
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
