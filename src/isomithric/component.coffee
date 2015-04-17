Module = require "./module"

module.exports = (m) ->
  
  class Component

    constructor: (@Klass) ->
      @Klass = @bindProps()
      @bindMethods()

    bindMethods: ->
      @Klass.prototype.component = (key, Klass, p, args...) ->
        Component.buildHelper(Klass, fn_name)(key, p, args...)

      for name, Klass of @Klass
        do (name, Klass) =>
          if Klass._isomithric?
            fn_name = @KlassToFnName(name)
            Klass   = @Klass[name]    = new Component(Klass).Klass
            @Klass.prototype[fn_name] = Component.buildHelper(Klass, fn_name)

    bindProps: ->
      Klass = @Klass

      class extends Module

        @mixin Klass
        @_isomithric: true
        
        constructor: (p) ->
          @include p
          @global ||= {}
          Klass.apply(@, arguments)

        param: (id) ->
          if @global.server
            @global.server.req.params[id]
          else
            m.route.param id

    @buildHelper: (Klass, fn_name) ->
      (args...) ->
        key = if typeof args[0] == "string"
          args.shift()

        p = if typeof args[0] == "object"
          args.shift()

        p ||= {}

        p.parent = @
        p.global = @.global
        
        if fn_name.match(/view$/)
          new Klass(p, args...).view()
        else if key
          @["_#{fn_name}_#{key}"] ||= new Klass(p, args...)
        else
          @["_#{fn_name}"] ||= new Klass(p, args...)

    @component: (Klass) ->
      new @(Klass).Klass

    KlassToFnName: (name) ->
      name
        .replace(/([A-Z])/g, "_$1")
        .toLowerCase()
        .substring(1)

  Component.component.bind(Component)
