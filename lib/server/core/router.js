"use strict";
var app, express, middlewares, root;

root = "" + __dirname + "/..";

express = require("express");

middlewares = require("" + root + "/core/router/middlewares.js");

app = express();

app.use(express.json());

app.use(express.urlencoded());

app.use(express.cookieParser());

app.use(middlewares.log);

require("" + root + "/controllers/public.js").init(app);

app.use(app.router);

module.exports = app;
