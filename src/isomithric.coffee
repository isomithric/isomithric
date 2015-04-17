component = require("./isomithric/component")
model     = require("./isomithric/model")
client    = require("./isomithric/client")

if typeof document == "undefined"
  obscure = "." # for browserify
  [ m, Server ] = require("#{obscure}/isomithric/server")

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
