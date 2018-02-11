class Dashing.JiraSwiperCurrentSprintIssues extends Dashing.Widget
 constructor: ->
   super
   @mySwiper = null
   @isReady = false
   @dataAdded = false
 ready: ->
   # This is fired when the widget is done being rendered
   # container = $(@node).find('.swiper-container')
   @isReady = true
   console.log('widget ready')
   @mySwiper = new Swiper($(@node).find('.swiper-container'),
     direction: 'horizontal'
     loop: true
     autoplay: 2000
     pagination: $(@node).find('.swiper-pagination'))
     
 addSlide: ->
   $(@node).find('.swiper-container .swiper-wrapper').prepend('<div class="swiper-slide"> <div class="wrapper"> <div class="left"> <img class="assignee-avatar" src=""> <div class="assignee-name"></div> </div> <div class="right"> <div class="issue-title"></div> <div class="issue-id"></div> </div> <div style="clear: both; padding-bottom: 1vh;"></div> </div> <div class="wrapper"> <div class="left"> <img class="assignee-avatar" src=""> <div class="assignee-name"></div> </div> <div class="right"> <div class="issue-title"></div> <div class="issue-id"></div> </div> <div style="clear: both; padding-bottom: 1vh;"></div> </div> <div class="wrapper"> <div class="left"> <img class="assignee-avatar" src=""> <div class="assignee-name"></div> </div> <div class="right"> <div class="issue-title"></div> <div class="issue-id"></div> </div> <div style="clear: both; padding-bottom: 1vh;"></div> </div> <div class="wrapper"> <div class="left"> <img class="assignee-avatar" src=""> <div class="assignee-name"></div> </div> <div class="right"> <div class="issue-title"></div> <div class="issue-id"></div> </div> <div style="clear: both; padding-bottom: 1vh;"></div> </div><div class="wrapper"> <div class="left"> <img class="assignee-avatar" src=""> <div class="assignee-name"></div> </div> <div class="right"> <div class="issue-title"></div> <div class="issue-id"></div> </div> <div style="clear: both; padding-bottom: 1vh;"></div> </div></div>')
 
 fillSlide: (slideIndex, issues) ->
   console.log($($(@node).find('.swiper-container .swiper-wrapper .swiper-slide:not(.swiper-slide-duplicate)')[slideIndex-1]))
   for value, index in issues
     $($(@node).find('.swiper-container .swiper-wrapper .swiper-slide:not(.swiper-slide-duplicate)')[slideIndex-1]).find('.wrapper:nth-child(' + (index+1).toString() + ')' + ' .right .issue-id').text(value.id)
     $($(@node).find('.swiper-container .swiper-wrapper .swiper-slide:not(.swiper-slide-duplicate)')[slideIndex-1]).find('.wrapper:nth-child(' + (index+1).toString() + ')' + ' .right .issue-title').text(value.title)
     $($(@node).find('.swiper-container .swiper-wrapper .swiper-slide:not(.swiper-slide-duplicate)')[slideIndex-1]).find('.wrapper:nth-child(' + (index+1).toString() + ')' + ' .left .assignee-name').text(value.assigneeName)
 dummy: (data) ->
   # Handle incoming data
   chunkArrays = []
   chunk = 5
   i = 0
   
   while i < data.issues.length
     chunkArrays.push data.issues.slice(i, i + chunk)
     # do whatever
     i += chunk
   noOfSlides = $(@node).find('.swiper-container .swiper-wrapper .swiper-slide').length
   console.log('noOfSlides ' + noOfSlides + ' chunkArrays.length ' + chunkArrays.length)
   
   for issues, index in chunkArrays
     source   = $("#entry-template").html()
     template = Handlebars.compile(source)
     html    = template({"issues":issues})
     # console.log(html)
     @mySwiper.appendSlide("<div class='swiper-slide'>#{html}</div>")
   
   @mySwiper.update(true)
   @mySwiper.startAutoplay()
   @dataAdded = true
   
 onData: (data) ->
   if(@isReady == false)
     return 1
   if(@dataAdded)
     thing = @mySwiper
     that = this
     datam = data
     @mySwiper.stopAutoplay()
     # @mySwiper.removeSlide(0)
     @mySwiper.removeAllSlides()
     setTimeout ->
       # thing.removeAllSlides()
       setTimeout ->
         that.dummy(datam)
       , 1000
     , 100
     return 1
     
   # Handle incoming data
   chunkArrays = []
   chunk = 5
   i = 0
   
   while i < data.issues.length
     chunkArrays.push data.issues.slice(i, i + chunk)
     # do whatever
     i += chunk
   noOfSlides = $(@node).find('.swiper-container .swiper-wrapper .swiper-slide').length
   console.log('noOfSlides ' + noOfSlides + ' chunkArrays.length ' + chunkArrays.length)
   
   for issues, index in chunkArrays
     source   = $("#entry-template").html()
     template = Handlebars.compile(source)
     html    = template({"issues":issues})
     # console.log(html)
     @mySwiper.appendSlide("<div class='swiper-slide'>#{html}</div>")
   
   @mySwiper.update(true)
   @mySwiper.startAutoplay()
   @dataAdded = true