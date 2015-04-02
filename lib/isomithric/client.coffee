_         = require "lodash"
m         = require "mithril"
promise   = require "es6-promise"
sugartags = require "mithril.sugartags"

module.exports = class

  constructor: (routes) ->
    # Bind sugartags to window.
    #
    sugartags(m, window)

    # Set up routes.
    #
    m.route.mode = "pathname"

    _.each routes, (Component, path) ->
      routes[path] =
        controller: Component
        view:       (c) -> c.render()

    # ES6 promises polyfill.
    #
    promise.polyfill()

    # Kick mithril off.
    #
    m.route document.body, "/", routes
