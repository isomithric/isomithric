iso = require("../../../lib/isomithric")

describe "Component", ->

  beforeAll ->
    @Component = iso class

      constructor: (p, arg) ->
        @constructed = true
        @extra_arg   = arg
        @hello_value = @hello
        @my_component(world: "world", true)
        @my_component("key", world: "world", true)

      view: ->
        @my_view(world: "world", true)
      
      @MyView: iso class
        constructor: (p, @bool) ->
        view: -> "#{@parent.hello} #{@world}" if @bool

      @MyComponent: iso class
        view: -> "#{@parent.hello} #{@world}"

    @component = new @Component(hello: "hello", global: "global", true)
    @view      = @component.view()

  describe "constructor", ->

    it "executes the original constructor", ->
      expect(@component.constructed).toBe true

    it "passes the extra argument", ->
      expect(@component.extra_arg).toBe true

    it "binds the properties parameter", ->
      expect(@component.hello).toBe "hello"

    it "binds the properties parameter before the constructor runs", ->
      expect(@component.hello_value).toBe "hello"

  describe "sub-components", ->

    it "binds the parameters", ->
      expect(@component.my_component().view()).toBe "hello world"
      expect(@component.my_component("key").view()).toBe "hello world"

    it "caches the component", ->
      expect(@component._my_component).not.toBe undefined
      first  = @component.my_component()
      second = @component.my_component()
      expect(first).toBe second

    it "caches the component by key", ->
      expect(@component._my_component_key).not.toBe undefined
      first  = @component.my_component("key")
      second = @component.my_component("key")
      expect(first).toBe second

    it "passes the global object along", ->
      expect(@component.global).not.toBe undefined
      expect(@component.my_component().global).toBe @component.global

  describe "view", ->

    it "binds the parameters", ->
      expect(@view).toBe "hello world"

    it "does not cache the view", ->
      @component.my_view()
      expect(@component._my_view).toBe undefined

  describe "mixins", ->

    beforeAll ->
      @functions = [ "extend", "include", "merge", "mixin" ]

    it "extends Module", ->
      @functions.forEach (fn) =>
        expect(_.isFunction(@Component[fn])).toBe true

    it "includes Module", ->
      @functions.forEach (fn) =>
        expect(_.isFunction(@component[fn])).toBe true
