Component = require("../../../lib/isomithric").Component
Server    = require("../../../lib/isomithric").Server

describe "Server", ->

  beforeAll ->
    @Component = class extends Component
      
      @State: class
        constructor: (p) ->
      
      @View: class
        constructor: ->
        render: ->
          HTML "hello"

    @server = new Server("/": @Component)

  describe "#render", ->

    it "renders", ->
      @server.render()
