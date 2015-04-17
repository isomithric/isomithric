# Fake `XMLHttpRequest` for `m.request`.
#
global.window = require "xmlhttprequest"

# Fake `setTimeout` for mithril.
#
global.window.setTimeout = setTimeout

m          = require "mithril"
render     = require "mithril-node-render"
sugartags  = require "mithril.sugartags"

# Make sugartags global.
#
sugartags(m, global)

Server = class

  constructor: (app, routes) ->
    # Set up static routes.
    #
    for path, Component of routes
      do (path, Component) =>
        app.get path, (req, res, next) =>
          res.type "html"
          @view(
            Component
            res
            global:
              server:
                next: next
                req:  req
                res:  res
          )

  view: (Component, res, props={}) ->
    props.global          ||= {}
    props.global.promises ||= []
    component = new Component(props)
    m.sync(props.global.promises).then ->
      res.end render(component.view())

module.exports = [ m, Server ]
