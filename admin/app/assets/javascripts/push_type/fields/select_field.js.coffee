# jQuery init
$(document).on 'ready page:load', ->

    $('select', '.select').selectize
    plugins:      ['remove_button']
    hideSelected: false
