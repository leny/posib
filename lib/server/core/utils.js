
/*
 * posib.
 * http://posib.krkn.be
 *
 * server/core/utils.js
 * Misc. utils functions
 *
 * coded by leny @ krkn
 * started at 02/02/14
 */
"use strict";
var bench, clc, log, oBenches, root, sleep, _doNothing;

root = "" + __dirname + "/..";

clc = require("cli-color");

exports.log = log = function(sMessage, sContext, sMessageType) {
  var aMonthName, dDate, iHours, iMinutes, iSeconds, sDatePrefix, sHours, sMinutes, sSeconds;
  if (sContext == null) {
    sContext = "node";
  }
  if (sMessageType == null) {
    sMessageType = "LOG";
  }
  aMonthName = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  dDate = new Date();
  sHours = (iHours = dDate.getHours()) < 10 ? "0" + iHours : iHours;
  sMinutes = (iMinutes = dDate.getMinutes()) < 10 ? "0" + iMinutes : iMinutes;
  sSeconds = (iSeconds = dDate.getSeconds()) < 10 ? "0" + iSeconds : iSeconds;
  sDatePrefix = "" + (dDate.getDate()) + " " + aMonthName[dDate.getMonth()] + " " + sHours + ":" + sMinutes + ":" + sSeconds;
  sMessage = "[" + sContext + "] " + sMessage;
  switch (sMessageType) {
    case "ERROR":
    case "ERR":
    case "RED":
      return console.log(sDatePrefix, clc.red.bold(sMessage));
    case "WARNING":
    case "WARN":
    case "YELLOW":
      return console.log(sDatePrefix, clc.yellow(sMessage));
    case "SUCCESS":
    case "GREEN":
      return console.log(sDatePrefix, clc.green(sMessage));
    case "MAGENTA":
      return console.log(sDatePrefix, clc.magenta(sMessage));
    default:
      return console.log(sDatePrefix, clc.cyan(sMessage));
  }
};

oBenches = {};

exports.bench = bench = function(sName) {
  var aEnd, iDiff, sDiff;
  if (!oBenches[sName]) {
    return oBenches[sName] = process.hrtime();
  } else {
    iDiff = Math.round(((aEnd = process.hrtime(oBenches[sName]))[0] * 1e9 + aEnd[1]) / 1000) / 1000;
    sDiff = iDiff > 1000 ? "" + (Math.round(iDiff / 100) / 10) + "s" : (iDiff > 25 ? "" + (Math.round(iDiff)) + "ms" : "" + iDiff + "ms");
    log("took " + sDiff + ".", sName || "TIMER", "YELLOW");
    return delete oBenches[sName];
  }
};

_doNothing = function() {};

exports.sleep = sleep = function(iDuration) {
  var dEnd, _results;
  dEnd = (new Date()).getTime() + (1000 * iDuration);
  _results = [];
  while ((new Date()).getTime() <= dEnd) {
    _results.push(_doNothing());
  }
  return _results;
};
