sugartags = require "mithril.sugartags"

module.exports = (m) ->
  
  class

    constructor: (routes) ->
      # Bind sugartags to window.
      #
      sugartags(m, window)

      # Set up routes.
      #
      m.route.mode = "pathname"

      for path, Component of routes
        do (path, Component) =>
          routes[path] =
            controller: ->
              new Component(global: promises: [])
            view: (c) -> c.view()

      # Kick mithril off.
      #
      m.route document.body, "/", routes
