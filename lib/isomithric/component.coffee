Module = require "./module"

module.exports = class Component

  constructor: ->
    @render = @render.bind(@)

    if @constructor.View
      Module.mixin(@constructor.View, Component.View)

    if @constructor.State
      Module.mixin(@constructor.State, Component.State)

      @state = new @constructor.State(arguments...)

  render: (p, children) ->
    @view = new @constructor.View(p, @state)
    @view.render(children)

  @State: class extends Module

  @View:  class extends Module

    param: (id) =>
      if @server
        @server.req.params[id]
      else
        m.route.param id
