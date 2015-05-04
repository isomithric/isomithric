## Isomithric

An isomorphic javascript framework on top of Mithril.

### Goals

* Provide a generic pattern for creating mithril components with uni-directional data flow
* Server and client side rendering for components using a common routes file
* Implement `m.request` for server and client side
* Automatically wait for requests to finish before rendering server side

### Install

    npm install isomithric

### Typical app structure

* `components/` - Classes that hold state across redraws
* `models/` - Classes that access and store persistent (server) data
* `views/` - Classes that contain render logic and exist on a per-redraw basis
* `client.coffee` - Loads isomithric for the client (typically browserified)
* `routes.coffee` - Defines the routes for both server and client side
* `server.coffee` - Loads isomithric for the server (`node server.coffee`)

### Routes

Define routes using a simple format:

    module.exports =
      "/": require("./component")

### Isomithric Classes

Use Isomithric classes for components, models, and views.

Define an Isomithric class like so:

    m   = require "mithril"
    iso = require("isomithric")(m)

    module.exports = iso class

Isomithric classes provide the following features:

* Automatic option binding
* Component creation helpers
* Class mixins
* Promise detection

### Automatic option binding

Isomithric classes take an options object as the first parameter to the constructor. Isomithric automatically binds these values as class instance variables.

    Component = require "./component"          # Isomithric class
    component = new Component(title: "Hello")  # Pass options to constructor
    component.title == "hello"                 # true

### Component creation helpers

When you add a reference to another isomithric class, you have access to a helper method that constructs an instance of that class:

    iso class
      @MyComponent: require "./component"
      
      constructor: ->
        @myComponent(title: "hello")  # `@my_component = new Component(title: "hello")`
        @myComponent()                # `@my_component`

If you define a component ending in `View`, then the helper behaves differently:

    iso class
      @MyView: require "../views/view"
      
      constructor: ->
        @myView(title: "hello")  # `new MyView(title: "hello").view()`
        @myView()                # `new MyView().view()`

The difference in behavior exists to promote the idea that components should hold state and maintain references to other components. Views should only exist for the lifetime of the render (the `view` call).

### Class mixins

You can easily add another class' instance and class methods with one call:

    iso class
      constructor: ->
        @mixin require("./component")

### Promise detection

Isomithric knows to do the final server side render when all promises returned from a function have resolved.

    iso class
      constructor: ->
        @get()
      
      get: ->
        deferred = m.deferred()
        setTimeout deferred.resolve, 100
        deferred.promise
      
      view: -> "hello"

If this class were a route component, it would render "hello" after 100ms. This functionality is useful when you need to wait for all `m.request` (or other) promises to resolve before rendering.
        
### Example project

Checkout the [isomithric-example project](https://github.com/isomithric/isomithric-example) for a working example.
