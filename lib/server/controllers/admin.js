"use strict";
var Parser, admin, config, root;

root = "" + __dirname + "/..";

config = require("" + root + "/core/config.js");

Parser = require("" + root + "/core/parser.js");

admin = function(oRequest, oResponse) {
  var page;
  page = new Parser("/" + (config.get().home));
  return page.showConnect(function(oError, sContent) {
    if (oError) {
      oResponse.send(oError.type || 500, oError.message);
    }
    return oResponse.send(sContent);
  });
};

exports.init = function(oApp) {
  return oApp.get("/admin/", admin);
};
