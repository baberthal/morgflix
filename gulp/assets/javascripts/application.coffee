$(() ->
  $('#new_series').on('click', ->
    console.log 'clicked!'
    $('#search-area').slideToggle()
  )

  $('#series_search').submit((e) ->
    e.prevent_default
    $('#results').slideToggle()
  )
)

#  vim: set ts=8 sw=2 tw=0 ft=coffee et :
