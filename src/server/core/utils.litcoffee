# [http://posib.krkn.be](posib.)

## **/server/core/utils.js** - *misc. utils functions*

coded by leny @ krkn

started at 02/02/14

* * *

    "use strict"

    root = "#{ __dirname }/.."

    chalk = require "chalk"

### log()

Formatted console log, with date, color & context.

    log = ( sMessage, sContext = "node", sMessageType = "LOG" ) ->
        aMonthName = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ]
        dDate = new Date()
        sHours = if ( iHours = dDate.getHours() ) < 10 then "0#{ iHours }" else iHours
        sMinutes = if ( iMinutes = dDate.getMinutes() ) < 10 then "0#{ iMinutes }" else iMinutes
        sSeconds = if ( iSeconds = dDate.getSeconds() ) < 10 then "0#{ iSeconds }" else iSeconds
        sDatePrefix = "#{ dDate.getDate() } #{ aMonthName[ dDate.getMonth() ] } #{ sHours }:#{ sMinutes }:#{ sSeconds }"
        sMessage = "[#{ sContext }] #{ sMessage }"
        switch sMessageType
            when "ERROR", "ERR", "RED"
                console.log "#{ sDatePrefix } - #{ chalk.red.bold( sMessage ) }"
            when "WARNING", "WARN", "YELLOW"
                console.log "#{ sDatePrefix } - #{ chalk.yellow( sMessage ) }"
            when "SUCCESS", "GREEN"
                console.log "#{ sDatePrefix } - #{ chalk.green( sMessage ) }"
            when "MAGENTA"
                console.log "#{ sDatePrefix } - #{ chalk.magenta( sMessage ) }"
            else
                console.log "#{ sDatePrefix } - #{ chalk.cyan( sMessage ) }"

    exports.log = log

### bench()

Simple bench tools for console.

    oStart = {}
    bench = ( sName ) ->
        if !oStart[ sName ]
            oStart[ sName ] = process.hrtime()
        else
            iDiff = Math.round( ( ( aEnd = process.hrtime( oStart[ sName ] ) )[ 0 ] * 1e9 + aEnd[ 1 ] ) / 1000 ) / 1000
            sDiff = if iDiff > 1000 then "#{ Math.round( iDiff / 100 ) / 10 }s" else ( if iDiff > 25 then "#{ Math.round( iDiff ) }ms" else "#{ iDiff }ms" )
            log "took #{ sDiff }.", ( sName or "TIMER" ), "YELLOW"
            delete oStart[ sName ]

    exports.bench = bench

### sleep()

Old-time, *quick&dirty* sleep function. Used to prevent bruteforce.

    _doNothing = ->
        return

    sleep = ( iDuration ) ->
        dEnd = ( new Date() ).getTime() + ( 1000 * iDuration )
        while ( new Date() ).getTime() <= dEnd
            _doNothing()

    exports.sleep = sleep
