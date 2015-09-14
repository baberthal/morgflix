$(() ->
  $('#new_series').on('click', ->
    console.log 'clicked!'
    $('#search-area').slideToggle()
  )
)

#  vim: set ts=8 sw=2 tw=0 ft=coffee et :
