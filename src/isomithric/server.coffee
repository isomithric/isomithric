fakejax    = require "xmlhttprequest"
m          = require "mithril"
render     = require "mithril-node-render"
sugartags  = require "mithril.sugartags"

# Make sugartags global.
#
sugartags(m, global)

# Fake `XMLHttpRequest` for `m.request`.
#
global.window = fakejax

# Fake `setTimeout` for mithril.
#
global.window.setTimeout = setTimeout

module.exports = class

  constructor: (app, routes) ->
    # Set up static routes.
    #
    for path, Component of routes
      do (path, Component) =>
        app.get path, (req, res, next) =>
          res.type "html"
          @view(
            Component
            global:
              server:
                next: next
                req:  req
                res:  res
          )

  view: (Component, props={}) ->
    props.global          ||= {}
    props.global.promises ||= []
    component = new Component(props)
    m.sync(props.global.promises).then ->
      props.global.server.res.end render(component.view())
