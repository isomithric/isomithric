## Isomithric

An isomorphic javascript framework on top of Mithril.

### Goals

* Provide a generic pattern for creating mithril components with uni-directional data flow
* Server and client side rendering for components using a common routes file
* Implement `m.request` for server and client side
* Automatically wait for requests to finish before rendering server side

### Install

    npm install isomithric

### Typical App Structure

* `components/` - Classes that hold state across redraws
* `models/` - Classes that access and store persistent (server) data
* `views/` - Classes that contain render logic and exist on a per-redraw basis
* `client.coffee` - Loads isomithric for the client (typically browserified)
* `server.coffee` - Loads isomithric for the server (`node server.coffee`)

### Example Project

Checkout the [isomithric-example project](https://github.com/isomithric/isomithric-example) for a working example.
