module.exports = class
  
  module_keywords = ['extended', 'included']

  @extend: (obj) ->
    for key, value of obj when key not in module_keywords
      @[key] = value

    obj.extended?.apply(@)
    @

  @include: (obj) ->
    for key, value of obj when key not in module_keywords
      # Assign properties to the prototype.
      #
      @::[key] = value

    obj.included?.apply(@)
    @
