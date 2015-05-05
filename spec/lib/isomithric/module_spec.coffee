iso = require("../../../src/isomithric")()

describe "Module", ->

  beforeAll ->
    Mixin = class
      test: (p) -> "hello #{p}"

    Mixin2 = class
      test2: (p) -> "hello #{p}"
      test3: -> "hello world 3"

    @Test = iso class
      constructor: ->
        @mixin Mixin
        @mixin Mixin2
      test: ->
        super("world")
      test2: ->
        super("world 2")

    @test = new @Test()

  describe "mixin", ->
    it "calls super on first mixin", ->
      expect(@test.test()).toBe "hello world"

    it "calls super on second mixin", ->
      expect(@test.test2()).toBe "hello world 2"

    it "returns correct value without super", ->
      expect(@test.test3()).toBe "hello world 3"
