"use strict";
var bench, clc, log, oStart, root, sleep, _doNothing;

root = "" + __dirname + "/..";

clc = require("cli-color");

log = function(sMessage, sContext, sMessageType) {
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

exports.log = log;

oStart = {};

bench = function(sName) {
  var aEnd, iDiff, sDiff;
  if (!oStart[sName]) {
    return oStart[sName] = process.hrtime();
  } else {
    iDiff = Math.round(((aEnd = process.hrtime(oStart[sName]))[0] * 1e9 + aEnd[1]) / 1000) / 1000;
    sDiff = iDiff > 1000 ? "" + (Math.round(iDiff / 100) / 10) + "s" : (iDiff > 25 ? "" + (Math.round(iDiff)) + "ms" : "" + iDiff + "ms");
    log("took " + sDiff + ".", sName || "TIMER", "YELLOW");
    return delete oStart[sName];
  }
};

exports.bench = bench;

_doNothing = function() {};

sleep = function(iDuration) {
  var dEnd, _results;
  dEnd = (new Date()).getTime() + (1000 * iDuration);
  _results = [];
  while ((new Date()).getTime() <= dEnd) {
    _results.push(_doNothing());
  }
  return _results;
};

exports.sleep = sleep;
