## isomithric

### Components

Here's an example of a component that uses a component:

    Article = require "./article"
    Sidebar = require "./sidebar"

    module.exports = class extends Component

      @State: class
        constructor: ->
          @sidebar = new Sidebar()

      @View: class
        constructor: (p, s) ->
          #   p = properties passed in via `Component.render`
          #   s = cached `State` instance
          #
          @server  = p.server
          @sidebar = s.sidebar.render

          # `@param` gets parameters client or server side.
          #
          id = @param("id")

          # `Article.map` is a simple key/value store for
          # `Article` instances.
          #
          @article = Article.map(id).render

        render: ->
          [
            HEADER("my header")
            @article(title: "hello")
            @sidebar()
          ]

Use the `State` class to hold any variables that need to persist over the lifetime of the component (including other components).

Every redraw, the framework creates a new instance of `View` and calls `render` on it.

### Models

Models are completely up to you to define, but have a basic signature:

    module.exports = class extends Model

The `Model` layer is responsible for persisting application data. It also wraps the business rules and logic around that data.

### Routes

Routes are located at `app/routes.coffee`.

    Home = require "./components/home"

    module.exports =
      "/": Home

Example of how to implement a layout server side:

    module.exports = class extends Component

      @State: class
        constructor: ->
          @layout = new Layout()

      @View: class
        constructor: (p, s) ->
          @layout = s.layout.render

          # The server property contains express.js params
          # (if server side).
          #
          @server = p.server

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
