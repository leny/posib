"use strict";
var Pandri, config, root, router;

root = __dirname;

Pandri = require("pandri");

config = require("" + root + "/core/config.js");

router = require("" + root + "/core/router.js");

exports.start = function(oConfig) {
  var store;
  config.init(oConfig);
  store = new Pandri("data");
  return store.load(config.get().contents + "/data.json", function() {
    return router.init(config.get().port, config.get().path);
  });
};
