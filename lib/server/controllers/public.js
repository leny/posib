"use strict";
var config, homepage, page, root;

root = "" + __dirname + "/..";

config = require("" + root + "/core/config.js");

homepage = function(oRequest, oResponse) {
  return oResponse.redirect(config.get().home);
};

page = function(oRequest, oResponse) {
  var sFilePath;
  sFilePath = config.get().path + oRequest.url;
  return oResponse.sendfile(sFilePath);
};

exports.init = function(oApp) {
  oApp.get("/", homepage);
  return oApp.get(/\/.+\.html?/i, page);
};
