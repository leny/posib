"use strict";
var Parser, config, homepage, page, root;

root = "" + __dirname + "/..";

config = require("" + root + "/core/config.js");

Parser = require("" + root + "/core/parser.js");

homepage = function(oRequest, oResponse) {
  return oResponse.redirect(config.get().home);
};

page = function(oRequest, oResponse) {
  page = new Parser(oRequest.url);
  return page.display(function(oError, sContent) {
    console.log(oError, sContent);
    return oResponse.sendfile(config.get().path + oRequest.url);
  });
};

exports.init = function(oApp) {
  oApp.get("/", homepage);
  return oApp.get(/\/.+\.html?/i, page);
};
