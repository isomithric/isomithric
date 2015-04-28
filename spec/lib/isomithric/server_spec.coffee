iso    = require("../../../src/isomithric")()
m      = require "mithril"
Server = iso.Server

describe "Server", ->

  beforeAll ->
    @Component = iso class
      constructor: ->
      view:        -> HTML "hello"

    @server = new Server("/": @Component)

  describe "#render", ->

    it "renders basic HTML", (done) ->
      res = end: (output) ->
      spyOn(res, "end")

      @server.view(@Component, res).then (output) ->
        expect(res.end).toHaveBeenCalledWith("<html>hello</html>")
        done()

    it "waits for promises", (done) ->
      deferred = m.deferred()
      promise  = deferred.promise
      
      setTimeout(
        -> deferred.resolve("hello")
        1
      )

      res = end: (output) ->
      spyOn(res, "end")

      @server.view(
        @Component
        res
        global: promises: [ promise ]
      ).then (output) ->
        expect(res.end).toHaveBeenCalledWith("<html>hello</html>")
        promise.then -> done()
