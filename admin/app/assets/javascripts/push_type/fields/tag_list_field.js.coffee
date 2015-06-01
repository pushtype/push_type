# jQuery init
$(document).on 'ready page:load', ->

  $('select', '.tag_list').selectize
    plugins:  ['remove_button', 'drag_drop']
    create:   true
    persist:  false
