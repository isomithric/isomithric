m = require "mithril"

iso    = require("../../../lib/isomithric")
Server = iso.Server

describe "Server", ->

  beforeAll ->
    @Component = iso class
      constructor: ->
      
      @View: iso class
        constructor: ->
        view:        -> HTML "hello"

    @server = new Server("/": @Component)

  describe "#render", ->

    it "renders basic HTML", (done) ->
      @server.view(@Component).then (output) ->
        expect(output).toBe "<html>hello</html>"
        done()

    it "waits for promises", (done) ->
      deferred = m.deferred()
      promise  = deferred.promise
      
      setTimeout(
        -> deferred.resolve("hello")
        1
      )

      @server.view(@Component, global: promises: [ promise ]).then (output) ->
        expect(output).toBe "<html>hello</html>"
        promise.then -> done()
