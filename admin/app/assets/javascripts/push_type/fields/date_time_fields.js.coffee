# jQuery init
$(document).on 'ready page:load', ->

  $('input', '.date').pickadate
    format: 'd mmmm yyyy'
    formatSubmit: 'yyyy-mm-dd'
    hiddenName: true

  $('input', '.time').pickatime
    format: 'h:i A'
    formatSubmit: 'HH:i'
    formatLabel: 'h:i A <sm!all>HH:i</sm!all>'
    hiddenName: true
