class Dashing.JiraSwiperCurrentSprintIssues extends Dashing.Widget
 constructor: ->
   super
   @mySwiper = null
   @isReady = false
   @dataAdded = false
 ready: ->
   @isReady = true
   console.log('widget ready')
   console.log(@get('issues'))
   @mySwiper = new Swiper($(@node).find('.swiper-container'),
     direction: 'horizontal'
     loop: true
     autoplay:
       delay: 5000
     pagination:
       el: '.swiper-pagination'
     )
     # pagination: $(@node).find('.swiper-pagination'))
   if(@get('issues'))
     this.foo(@get('issues'), @get('chunkSize'))  
 
 foo: (data, chunkSize) ->
   if(!data)
       return 1
   @mySwiper.autoplay.stop()
   chunkArrays = []
   chunk = chunkSize
   i = 0
   
   while i < data.length
     chunkArrays.push data.slice(i, i + chunk)
     i += chunk
   noOfSlides = $(@node).find('.swiper-container .swiper-wrapper .swiper-slide').length
   
   for issues, index in chunkArrays
     source   = $("#entry-template").html()
     template = Handlebars.compile(source)
     html    = template({"issues":issues})
     @mySwiper.appendSlide("<div class='swiper-slide'>#{html}</div>")
   
   @mySwiper.autoplay.delay = 10000
   @mySwiper.update()
   @mySwiper.pagination.render()
   #@mySwiper.autoplay.start()
   @dataAdded = true
   if(data.length > chunk)
     @mySwiper.autoplay.start()
 onData: (data) ->
   if(@isReady == false)
     return 1
   that = this
   datam = data
   if(@dataAdded)
     thing = @mySwiper
     @mySwiper.autoplay.stop()
     @mySwiper.removeAllSlides()
     setTimeout ->
       setTimeout ->
         that.foo(datam.issues, datam.chunkSize)
       , 1000
     , 100
     return 1
   if(data)
     that.foo(data.issues, data.chunkSize)
