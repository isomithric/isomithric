_      = require "lodash"
Module = require "./module"

module.exports = class extends Module

  constructor: ->
    if @constructor.State
      @state = new @constructor.State()
    
    @render = @render.bind(@)

  isChildren = (obj) ->
    _.isArray(obj) or _.size _.pick obj, [ "tag", "subtree" ]

  mapProps = (p, children) ->
    # `children` argument present, attach to props.
    #
    if children?
      p.children = children
    else
      # `p` is children. Make props be an object w/ children attached.
      #
      if isChildren(p) or not _.isObject p
        p = children: p

    p

  render: (p={}, children) ->
    p = mapProps p, children
    @view = new @constructor.View(p, @state)
    @view.render()


  @State: class extends Module

    _map: {}

    map: (key, count, value) ->
      @_map[key] ||= []

      return @_map[key] if !count && !value

      value      = -> value unless _.isFunction value
      values     = Array.apply(null, Array(count)).map value
      @_map[key] = @_map[key].concat values

      values

    unmap: (key, value) ->
      @_map[key] ||= []

      if value
        @_map[key] = _.remove(
          @_map[key]
          (item) -> item == value
        )
      else
        @_map[key] = []

      @_map[key]


  @View: class extends Module

    constructor: (p, s) ->
      [ @p, @s ] = [ p, s ]

      _.assign @, p
      _.assign @, s

    param: (id) =>
      if @server
        @server.req.params[id]
      else
        m.route.param id
