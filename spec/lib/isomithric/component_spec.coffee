Component = require("../../../lib/isomithric").Component

describe "Component", ->

  beforeAll ->
    @Component = class extends Component
      
      @State: class
        constructor: (p) ->
          @include p
      
      @View: class
        constructor: ->

  describe "#constructor", ->

    beforeEach ->
      @component = new @Component(hello: "world")

    describe "mixins", ->

      beforeAll ->
        @functions = [ "extend", "include", "merge", "mixin" ]
        @view      = new @Component.View()

      it "extends Module into State", ->
        @functions.forEach (fn) =>
          expect(_.isFunction(@Component.State[fn])).toBe true

      it "includes Module into State", ->
        @functions.forEach (fn) =>
          expect(_.isFunction(@component.state[fn])).toBe true

      it "extends Module into View", ->
        @functions.forEach (fn) =>
          expect(_.isFunction(@Component.View[fn])).toBe true

      it "includes Module into View", ->
        @functions.forEach (fn) =>
          expect(_.isFunction(@view[fn])).toBe true

      it "includes Component.View into View", ->
        expect(_.isFunction(@view.param)).toBe true

    describe "state", ->

      it "creates a new State instance", ->
        expect(_.isObject(@component.state)).toBe true

      it "passes Component constructor parameters to State", ->
        expect(@component.state.hello).toBe "world"
