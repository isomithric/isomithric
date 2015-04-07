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
      to[key] = value
    to

  @mixin: (to, from) ->
    [ to, from ] = [ @, to ] unless from

    @include(to, from)
    @extend(to, from)

  # Instance methods
  #

  extend: (from) ->
    @constructor.merge(@constructor, from)

  include: (from) ->
    @constructor.merge(@, from)

  merge: (from) ->
    @constructor.merge(@, from)

  mixin: (from) ->
    @constructor.mixin(@, from)
