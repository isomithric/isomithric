module.exports = class Module

  # Class methods
  #

  @extend: (to, from) ->
    [ to, from ] = [ @, to ] unless from

    @merge(to, from)

  @include: (to, from) ->
    [ to, from ] = [ @, to ] unless from

    @merge(to::, from::)

  @merge: (to, from) ->
    [ to, from ] = [ @, to ] unless from

    for key, value of from
      to[key] = value unless to[key]
    to

  @mixin: (to, from) ->
    [ to, from ] = [ @, to ] unless from

    @include(to, from)
    @extend(to, from)

  # Instance methods
  #

  enableSuper = (constructor, from) ->
    return unless constructor._klass

    constructor._klass.__super__ ||= from::
    constructor.merge(constructor._klass.__super__, from::)

  extend: (from) ->
    return unless from
    
    @constructor.merge(@constructor, from)

  include: (from) ->
    return unless from
    
    @constructor.merge(@, from)
    enableSuper(@constructor, from)

  merge: (from) ->
    return unless from
    
    @constructor.merge(@, from)

  mixin: (from) ->
    return unless from

    @constructor.mixin(@constructor, from)
    @include(from::)
    enableSuper(@constructor, from)
