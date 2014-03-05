###
 * posib.
 * http://posib.krkn.be
 *
 * server/core/utils.js
 * Misc. utils functions
 *
 * coded by leny @ krkn
 * started at 02/02/14
###

"use strict"

root = "#{ __dirname }/.."

clc = require "cli-color"

# log()
# Formatted console log, with date, color & context.

exports.log = log = ( sMessage, sContext = "node", sMessageType = "LOG" ) ->
    aMonthName = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ]
    dDate = new Date()
    sHours = if ( iHours = dDate.getHours() ) < 10 then "0#{ iHours }" else iHours
    sMinutes = if ( iMinutes = dDate.getMinutes() ) < 10 then "0#{ iMinutes }" else iMinutes
    sSeconds = if ( iSeconds = dDate.getSeconds() ) < 10 then "0#{ iSeconds }" else iSeconds
    sDatePrefix = "#{ dDate.getDate() } #{ aMonthName[ dDate.getMonth() ] } #{ sHours }:#{ sMinutes }:#{ sSeconds }"
    sMessage = "[#{ sContext }] #{ sMessage }"
    switch sMessageType
        when "ERROR", "ERR", "RED"
            console.log sDatePrefix, clc.red.bold sMessage
        when "WARNING", "WARN", "YELLOW"
            console.log sDatePrefix, clc.yellow sMessage
        when "SUCCESS", "GREEN"
            console.log sDatePrefix, clc.green sMessage
        when "MAGENTA"
            console.log sDatePrefix, clc.magenta sMessage
        else
            console.log sDatePrefix, clc.cyan sMessage

# bench()
# Simple bench tools for console.

oBenches = {}
exports.bench = bench = ( sName ) ->
    if !oBenches[ sName ]
        oBenches[ sName ] = process.hrtime()
    else
        iDiff = Math.round( ( ( aEnd = process.hrtime( oBenches[ sName ] ) )[ 0 ] * 1e9 + aEnd[ 1 ] ) / 1000 ) / 1000
        sDiff = if iDiff > 1000 then "#{ Math.round( iDiff / 100 ) / 10 }s" else ( if iDiff > 25 then "#{ Math.round( iDiff ) }ms" else "#{ iDiff }ms" )
        log "took #{ sDiff }.", ( sName or "TIMER" ), "YELLOW"
        delete oBenches[ sName ]

# sleep()
# Old-time, *quick&dirty* sleep function. Used to prevent bruteforce.

_doNothing = ->
    return

exports.sleep = sleep = ( iDuration ) ->
    dEnd = ( new Date() ).getTime() + ( 1000 * iDuration )
    while ( new Date() ).getTime() <= dEnd
        _doNothing()
