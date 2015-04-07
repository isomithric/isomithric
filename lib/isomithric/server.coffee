express    = require "express"
device     = require "express-device"
bodyParser = require "body-parser"
fakejax    = require "xmlhttprequest"
m          = require "mithril"
render     = require "mithril-node-render"
sugartags  = require "mithril.sugartags"

module.exports = class

  constructor: (routes) ->
    # Make sugartags global.
    #
    sugartags(m, global)

    # Fake `XMLHttpRequest` for `m.request`.
    #
    global.window = fakejax

    # Fake `setTimeout` for mithril.
    #
    global.window.setTimeout = setTimeout

    # Set up express.
    #
    @app = express()
    port = process.env.PORT or 8000

    @app.use bodyParser.urlencoded(extended: true)
    @app.use bodyParser.raw()
    @app.use bodyParser.json()
    @app.use express.static("./dist/app")
    @app.use device.capture()

    # Set up static routes.
    #
    for path, Component of routes
      ((path, Component) =>
        @app.get path, (req, res, next) =>
          res.type "html"
          res.end @render(
            promises: []
            server:
              next: next
              req:  req
              res:  res
          )
      )(path, Component)

  render: (props) ->
    output = new Component(props).render()
    m.sync(props.promises).then ->
      render(output)

  # Start express.
  #
  start: ->
    console.log "Server is now running on port " + port
    @app.listen port
