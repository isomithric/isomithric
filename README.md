## Isomithric

An isomorphic javascript framework for Mithril.

### What does it do?

* Full server side render on first load, single page app for subsequent routes
* Removes almost any need to distinguish between server or client within your code
* Provides a common convention for defining Mithril routes and components
* Allows you to use [m.request](http://lhorie.github.io/mithril/mithril.request.html) on server and client side
* Pre-defined gulp tasks for building your projects
* Global [sugartags](https://github.com/jsguy/mithril.sugartags)

### Get started

    npm install -g isomithric
    isomithric new_project
    cd new_project
    gulp

Now open [http://127.0.0.1:8000](http://127.0.0.1:8000).

### Components

Here's an example of a component that uses a component:

    Component = require("isomithric").Component
    Sidebar   = require "./sidebar"

    module.exports = class extends Component

      @State: class
        constructor: ->
          @sidebar = new Sidebar().render

      @View: class

        # p = properties passed in via `Component.render`
        # s = cached `State` instance
        #
        constructor: (p, s) ->

          # Assign class instance variables from `p` and `s`.
          #
          super(p, s)

        render: ->
          [
            HEADER("my header")
            @sidebar()
          ]

Use the `State` class to hold any variables that need to persist over the lifetime of the component (including other components).

Every redraw, the framework creates a new instance of `View` and calls `render` on it.

### Routes

Routes are located at `app/routes.coffee`.

    Home = require "./components/home"

    module.exports =
      "/": Home

### Models

Models are completely up to you to define, but have a basic signature:

    Model = require("isomithric").Model

    module.exports = class extends Model
      constructor: ->

The `Model` layer is responsible for persisting application data. It also wraps the business rules and logic around that data.

### Layouts

The only difference you should encounter between server and client side is that on server side, you need to render a layout:

    module.exports = class extends Component

      @State: class
        constructor: ->
          @layout = new Layout().render

      @View: class
        constructor: (p, s) ->
          super(p, s)

        render: ->
          content = HEADER("My Site")

          if @server
            @layout(content: content)
          else
            content

    Layout = class extends Component

      @State: class
        constructor: ->

      @View: class
        constructor: (p, s) ->
          @content = p.content
        
        render: ->
          HTML @content
