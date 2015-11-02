opts =
  date:
    format: 'd mmmm yyyy'
    formatSubmit: 'yyyy-mm-dd'
    hiddenName: true
  time:
    format: 'h:i A'
    formatSubmit: 'HH:i'
    formatLabel: 'h:i A <sm!all>HH:i</sm!all>'
    hiddenName: true

@app.directive 'pickadate', ->
  ($scope, $el, $attrs) ->
    switch $attrs['pickadate']
      when 'date' then $($el).pickadate opts.date
      when 'time' then $($el).pickatime opts.time
