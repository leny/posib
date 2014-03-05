
/*
 * posib.
 * http://posib.krkn.be
 *
 * server/core/router.js
 * Config & setup of the **expressjs** router.
 *
 * coded by leny @ krkn
 * started at 02/02/14
 */
"use strict";
var express, middlewares, root;

root = "" + __dirname + "/..";

express = require("express");

middlewares = require("" + root + "/core/router/middlewares.js");

exports.init = function(iPort, sStaticPath) {
  var app;
  app = express();
  app.use(express.json());
  app.use(express.urlencoded());
  app.use(express.cookieParser());
  app.use(middlewares.log);
  require("" + root + "/controllers/admin.js").init(app);
  require("" + root + "/controllers/public.js").init(app);
  app.use(app.router);
  app.use("/__posib", express["static"]("" + root + "/../client"));
  app.use(express["static"](sStaticPath));
  app.listen(iPort);
  return app;
};
