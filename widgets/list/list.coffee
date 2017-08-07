class Dashing.List extends Dashing.Widget
  onData: (data) ->
    for value, index in data.items
      $(@node).find('ul li:nth-child(' + (index+1).toString() + ')' + ' span.value').text(value.value)
      $(@node).find('ul li:nth-child(' + (index+1).toString() + ')' + ' span.label').text(value.label)