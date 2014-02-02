"use strict";
var root, utils;

root = "" + __dirname + "/../..";

utils = require("" + root + "/core/utils.js");

exports.log = function(oRequest, oResponse, fNext) {
  utils.log("(" + oRequest.method + ") " + oRequest.url, "router");
  return fNext();
};
