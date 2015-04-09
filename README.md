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

Checkout the [isomithric-example project](https://github.com/isomithric/isomithric-example) for a working example.

### Component Lifecycle

![Component Lifecycle](https://www.gliffy.com/go/publish/image/7745167/L.png)

*Note*: this is pseudocode, constructors have access to extended properties
