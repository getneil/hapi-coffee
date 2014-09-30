Hapi = require "hapi"
Good = require "good"
Path = require "path"
config = require "./config/settings"
routes = require './config/routes'

server = new Hapi.Server config.port,config.hapi.options

initialize = (cb)->

  server.route routes
  
  server.pack.register Good, (err) ->
    throw err  if err # something bad happened loading the plugin
    server.start ->
      server.log "info", "Server running at: " + server.info.uri
      cb() if cb
      return
    return
  return
initialize()
