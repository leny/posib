"use strict";
var Pandri, config, root, router;

root = __dirname;

Pandri = require("pandri");

config = require("" + root + "/core/config.js");

router = require("" + root + "/core/router.js");

exports.start = function(oConfig) {
  var bCacheIsLoaded, bDataIsLoaded;
  config.init(oConfig);
  if (!config.get().production) {
    Pandri.clear("data");
    Pandri.clear("cache");
  }
  bDataIsLoaded = false;
  bCacheIsLoaded = false;
  (new Pandri("data")).load("" + (config.get().contents) + "/data.json", function() {
    bDataIsLoaded = true;
    if (bDataIsLoaded && bCacheIsLoaded) {
      return router.init(config.get().port, config.get().path);
    }
  });
  return (new Pandri("cache")).load("" + (config.get().contents) + "/cache.json", function() {
    bCacheIsLoaded = true;
    if (bDataIsLoaded && bCacheIsLoaded) {
      return router.init(config.get().port, config.get().path);
    }
  });
};
