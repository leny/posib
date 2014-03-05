###
 * posib.
 * http://posib.krkn.be
 *
 * server/controllers/admin.js
 * The admin controller maps the admin routes, allowing to edit the content of the site.
 *
 * coded by leny @ krkn
 * started at 05/02/14
###

"use strict"

root = "#{ __dirname }/.."

config = require "#{ root }/core/config.js"
Parser = require "#{ root }/core/parser.js"

# [GET] /admin/
# Shows the connect modal if not connected, else redirect to the home page, logged.
admin = ( oRequest, oResponse ) ->
    page = new Parser "/#{ config.get().home }"
    page.showConnect ( oError, sContent ) ->
        oResponse.send ( oError.type or 500 ), oError.message if oError # TODO better error support
        oResponse.send sContent

# Declare routes
exports.init = ( oApp ) ->
    oApp.get "/admin/", admin
