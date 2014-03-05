
/*
 * posib.
 * http://posib.krkn.be
 *
 * server/controllers/public.js
 * The public controller maps the public routes, showing the parsed files of the site.
 *
 * coded by leny @ krkn
 * started at 02/02/14
 */
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
    if (oError) {
      oResponse.send(oError.type || 500, oError.message);
    }
    return oResponse.send(sContent);
  });
};

exports.init = function(oApp) {
  oApp.get("/", homepage);
  return oApp.get(/\/.+\.html?/i, page);
};
