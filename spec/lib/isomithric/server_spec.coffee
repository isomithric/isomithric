m = require "mithril"

Component = require("../../../lib/isomithric").Component
Server    = require("../../../lib/isomithric").Server

describe "Server", ->

  beforeAll ->
    @Component = class extends Component
      
      @State: class
        constructor: ->
      
      @View: class
        constructor: ->
        render:      -> HTML "hello"

    @server = new Server("/": @Component)

  describe "#render", ->

    it "renders basic HTML", (done) ->
      @server.render(@Component).then (output) ->
        expect(output).toBe "<html>hello</html>"
        done()

    it "waits for promises", (done) ->
      deferred = m.deferred()
      promise  = deferred.promise
      
      setTimeout(
        -> deferred.resolve("hello")
        1
      )

      @server.render(@Component, promises: [ promise ]).then (output) ->
        expect(output).toBe "<html>hello</html>"
        promise.then -> done()
