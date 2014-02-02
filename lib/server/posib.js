"use strict";
var config, root, router;

root = __dirname;

config = require("" + root + "/core/config.js");

router = require("" + root + "/core/router.js");

exports.start = function(oConfig) {
  config.init(oConfig);
  return router.init(config.get().port, config.get().path);
};
