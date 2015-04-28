Module = require "./module"

module.exports = (m) ->
  
  class Component

    constructor: (@Klass) ->
      @Klass = @bindProps()
      @bindMethods()

    bindMethods: ->
      for name, Klass of @Klass
        do (name, Klass) =>
          if Klass._isomithric?
            fn_name  = @klassToFnName(name)
            var_name = @klassToVarName(name)

            Klass    = @Klass[name]   = new Component(Klass).Klass
            @Klass.prototype[fn_name] = Component.buildHelper(Klass, fn_name, var_name)

    bindProps: ->
      Klass = @Klass

      class extends Module

        @mixin Klass
        @_isomithric: true
        
        constructor: (p) ->
          @include p
          
          @global ||= {}
          @server   = @global.server

          Klass.apply(@, arguments)

          for name, fn of @
            stop   = name == "constructor"
            stop ||= typeof @[name] != "function"
            unless stop
              do (name, fn) =>
                @[name] = =>
                  promise = fn.apply(@, arguments)
                  if promise && promise.then
                    @global.promises.push promise
                  promise

        param: (id) ->
          if @server
            @server.req.params[id]
          else
            m.route.param id

    @buildHelper: (Klass, fn_name, var_name) ->
      (args...) ->
        key = if typeof args[0] == "string"
          args.shift()

        p = if typeof args[0] == "object"
          args.shift()

        p ||= {}

        p.parent = @
        p.global = @.global
        p.server = @.global.server
        
        if fn_name.match(/View$/)
          new Klass(p, args...).view()
        else if key
          @["#{var_name}_#{key}"] ||= new Klass(p, args...)
        else
          @["#{var_name}"] ||= new Klass(p, args...)

    @component: (Klass) ->
      new @(Klass).Klass

    klassToFnName: (name) ->
      name.charAt(0).toLowerCase() + name.slice(1)

    klassToVarName: (name) ->
      name
        .replace(/([A-Z])/g, "_$1")
        .toLowerCase()
        .substring(1)

  Component.component.bind(Component)
