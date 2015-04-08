## Isomithric

An isomorphic javascript framework on top of Mithril.

### Philosophy

* Class-based unidirectional data flow
* Apps are comprised of "Components" and "Models"
* Components hold state and business logic for views
* Models hold persistent data and business logic for that data

### Goals

* Server-side render on first page load, dynamic rendering for subsequent actions
* Server-side [m.request](http://lhorie.github.io/mithril/mithril.request.html) implementation
* Server-side [m.route.param](http://lhorie.github.io/mithril/mithril.route.html#defining-routes) implementation
* Global [sugartags](https://github.com/jsguy/mithril.sugartags)
* Automatic constructor property argument binding
* Mixin support for classes

### Install

    npm install isomithric

### Example

`models/article.coffee`:

    module.exports = Iso.model

      get: ->
        m.request method: "GET", url: "/article/#{@id}"

`components/article.coffee`:

    Article = require "./models/article"

    module.exports = Iso.component

      constructor: ->
        @article = new Article(id: @id).get()

      View: class
        view: ->
          [
            HEADER @article.title
            DIV    @article.body
          ]

`components/home.coffee`:

    Article = require "./components/article"

    module.exports = Iso.component

      constructor: ->
        @article = new Article id: m.route.param("id")

      View: class
        view: ->
          if @server
            HTML [
              BODY [
                @article.view()
                SCRIPT src: "/scripts/client.js"
              ]
            ]
          else
            @article.view()

`routes.coffee`:

    Home = require "./components/home"

    module.exports =
      "/": Home

`server.coffee`:

    Iso    = require "isomithric"
    routes = require "./routes.coffee"

    app = require("express")()
    app.use express.static "./dist/app"

    new Iso.server app, routes

`client.coffee`:

    Iso    = require "isomithric"
    routes = require "./routes.coffee"

    new Iso.client routes

[Use a gulp task](https://gist.github.com/winton/7811015fd6ee7b523232) to compile and browserify `client.coffee`.

#### Start the server

    coffee server.coffee

### Component Lifecycle

![Component Lifecycle](https://www.gliffy.com/go/publish/image/7745167/L.png)

*Note*: this is pseudocode, constructors have access to extended properties
