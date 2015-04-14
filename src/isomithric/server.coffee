fakejax    = require "xmlhttprequest"
m          = require "mithril"
render     = require "mithril-node-render"
sugartags  = require "mithril.sugartags"

module.exports = class

  constructor: (app, routes) ->
    # Make sugartags global.
    #
    sugartags(m, global)

    # Fake `XMLHttpRequest` for `m.request`.
    #
    global.window = fakejax

    # Fake `setTimeout` for mithril.
    #
    global.window.setTimeout = setTimeout

    # Set up static routes.
    #
    for path, Component of routes
      do (path, Component) =>
        app.get path, (req, res, next) =>
          res.type "html"
          res.end @view(
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
    output = new Component(props).view()
    m.sync(props.global.promises).then -> render(output)
