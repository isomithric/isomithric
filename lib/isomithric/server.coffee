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
          res.end @render(
            Component
            server:
              next: next
              req:  req
              res:  res
          )

  render: (Component, props={}) ->
    props.promises ||= []
    output = new Component(props).render()
    m.sync(props.promises).then -> render(output)
