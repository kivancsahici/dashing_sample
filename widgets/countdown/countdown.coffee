class Dashing.Countdown extends Dashing.Widget
  ready: ->
    # $(@node).find(".more-info").html('31-Aug-2018 10:30:00')
    @tempDate = new Date()
    @tempDate.setDate(@tempDate.getDate() + 6)
    @end_timestamp = Math.round(@tempDate.getTime()/1000)
    $(@node).find(".more-info").html(@tempDate.getDate())
    window.refreshIntervalId = setInterval(@startCountdown, 500)

  startCountdown: =>
    current_date = new Date()
    current_timestamp = Math.round(current_date.getTime()/1000)
    #end_timestamp = Math.round( Date.parse($(@node).find(".more-info").html())/1000 )
    #current_date.setDate(current_date.getDate() + 6)
    #end_timestamp = Math.round(current_date.getTime()/1000)
    seconds_until_end = @end_timestamp - current_timestamp
    if seconds_until_end < 0
      @set('timeleft', "TIME UP!")
      for i in [0..5] by 1
        $(@node).fadeTo('slow', 0).fadeTo('slow', 1.0)
      clearInterval(refreshIntervalId)
    else
      d = Math.floor(seconds_until_end/86400)
      h = Math.floor((seconds_until_end-(d*86400))/3600)
      m = Math.floor((seconds_until_end-(d*86400)-(h*3600))/60)
      s = seconds_until_end-(d*86400)-(h*3600)-(m*60)
      if d >0
        dayname = 'day'
        if d > 1
          dayname = 'days'
        @set('timeleft', d + " "+dayname+" " + @formatTime(h) + ":" + @formatTime(m) + ":" + @formatTime(s))
      else
        @set('timeleft', @formatTime(h) + ":" + @formatTime(m) + ":" + @formatTime(s))


  formatTime: (i) ->
    if i < 10 then "0" + i else i