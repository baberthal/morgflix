vid            = document.querySelector('video')
playButton     = document.querySelector('#play')
pauseButton    = document.querySelector('#pause')
castButton     = document.querySelector('#cast')
progressSlider = document.querySelector('#progress')
vidBox = $('#video-box')

playButton.addEventListener('click', ->
  vid.play()
)

pauseButton.addEventListener('click', ->
  vid.pause()
)

castButton.addEventListener('click', ->
  vid.launchSessionManager()
)

progressSlider.addEventListener('mouseup', ->
  duration = vid.duration
  newPosition = (duration / 100) * @value
  vid.currentTime = newPosition
)

vid.addEventListener('google-castable-video-timeupdate', (e) ->
  duration = vid.duration
  currentTime = e.detail.currentTime
  progressSlider.value = currentTime * ( 100 / duration )
)

vid.addEventListener('google-castable-video-casting', (e) ->
  if e.detail.casting
    castButton.innerHTML = "STOP CASTING"
  else
    castButton.innerHTML = "START CASTING"
)

vidBox.on('mouseenter', ->
  $('#controls').slideDown()
)

vidBox.on('mouseleave', ->
  $('#controls').slideUp()
)

#  vim: set ts=8 sw=2 tw=0 ft=coffee et :
