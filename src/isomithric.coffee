component = require("./isomithric/component")
model     = require("./isomithric/model")
client    = require("./isomithric/client")

if typeof document == "undefined"
  [ m, Server ] = require("./isomithric/server")

builder = (m) ->
  iso        = component(m)
  iso.model  = model(m)
  iso.Client = client(m)
  iso.Server = Server if Server
  iso

module.exports = 
  if m
    -> builder(m)
  else
    builder
