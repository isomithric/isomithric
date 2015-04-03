_          = require "lodash"
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
    _.each routes, (Component, path) ->
      @app.get path, (req, res, next) ->
        res.type "html"

        res.end render(
          new Component().render(
            server:
              next: next
              req:  req
              res:  res
          )
        )

    # Start express.
    #
    console.log "Server is now running on port " + port
    @app.listen port
