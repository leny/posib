"use strict";
var config, homepage, root;

root = "" + __dirname + "/..";

config = require("" + root + "/core/config.js");

homepage = function(oRequest, oResponse) {
  return oResponse.send("hey, this is the homepage, no ?");
};

exports.init = function(oApp) {
  return oApp.get("/", homepage);
};
