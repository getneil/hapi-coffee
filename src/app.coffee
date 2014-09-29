Hapi = require "hapi"
Good = require "good"
Path = require "path"
config = require "./config/settings"

server = new Hapi.Server config.port,config.hapi.options

initialize = (cb)->

  server.route
    method: "GET"
    path: "/"
    handler: (request, reply) ->
      reply "hello world"
      return

  server.route
    method:"GET"
    path:"/assets/{param*}"
    handler:
      directory:
        path:"./assets/"
        listing:true

  server.pack.register Good, (err) ->
    throw err  if err # something bad happened loading the plugin
    server.start ->
      server.log "info", "Server running at: " + server.info.uri
      cb() if cb
      return
    return
  return
initialize()
