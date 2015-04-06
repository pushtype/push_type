@app.directive 'ptConfirmReveal', ->
  ($scope, $el, $attrs) ->
    # Options
    defaults =
      title:  'Are you sure?'
      body:   'This action cannot be undone.'
    option = (name) -> $el.data(name) || defaults[name]

    # Define modal
    $modal = $("""
      <div data-reveal class="reveal-modal small">
        <h2 pt-title></h2>
        <p pt-body></p>
        <div>
          <button class="button alert" pt-confirm>OK</button>
          <button class="button secondary" pt-cancel>Cancel</button>
        </div>
      </div>
    """)

    $modal.find('[pt-title]').html option('title')
    $modal.find('[pt-body]').html option('body')

    # Define confirm callback
    callbackFn = new Function('$scope', "$scope.#{ $attrs.ptConfirmReveal }")

    # Bind events
    $modal.find('[pt-confirm]').on 'click', (e) ->
      e.preventDefault()
      callbackFn($scope)
      $modal.foundation('reveal', 'close')
    $modal.find('[pt-cancel]').on 'click', (e) ->
      e.preventDefault()
      $modal.foundation('reveal', 'close')

    # Reveal the modal
    $el.on 'click', (e) ->
      e.preventDefault()
      $modal
        .appendTo('body')
        .foundation('reveal', 'open')
        .on 'closed.fndtn.reveal', (e) ->
          $modal.remove()
