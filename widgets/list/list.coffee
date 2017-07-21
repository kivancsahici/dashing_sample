class Dashing.List extends Dashing.Widget
  ready: ->
    if @get('unordered')
      # console.log('ready')
      # $(@node).find('ol').remove()
      # console.log($(@node))
      # console.log(food) for food in $(@node).find('ul li')
      # console.log('hello' + $(food).val()) for food in $(@node).find('ul li:first-child span.label')
      # console.log(food) for food in $(@node).find('ul li:first-child span.label')
      # $(@node).find('ul li:first-child span.label').remove()
    else
      $(@node).find('ul').remove()
  onData: (data) -> 
    # console.log('ondata')
    
    for value, index in data.items
      $(@node).find('ul li:nth-child(' + (index+1).toString() + ')' + ' span.value').text(value.value)
      $(@node).find('ul li:nth-child(' + (index+1).toString() + ')' + ' span.label').text(value.label)
      
      console.log(index + ' ' + value.label + ' ' + value.value)
    # $(@node).fadeOut().fadeIn()
    # console.log value, index
    # $(@node).find('ul li span.label').text(data.items[0].label)
    # $(@node).find('ul li span.value').text(data.items[0].value)
    # $(@node).fadeOut().fadeIn()
    # console.log($($(food).find('span')[0]).val()) for food in $(@node).find('ul li')
    # console.log(data.items)