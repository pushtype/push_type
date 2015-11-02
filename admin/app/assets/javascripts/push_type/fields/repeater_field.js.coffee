@app.directive 'repeaterField', ['$compile', '$timeout', ($compile, $timeout) ->
  {
    restrict: 'A'
    scope: true
    link: ($scope, $el, $attrs) ->
      $rows     = $('.rows', $el)
      template  = $('.template', $el).text()

      $scope.addRow = ->
        uid   = Math.uid()
        $row  = $(template)
        $row.attr 'data-uid', uid
        $rows.append $row
        $dom = $("[data-uid='#{ uid }']", $rows)
        $compile($dom)($scope)
        $timeout -> $dom.trigger('init.fndtn')
        true

      $scope.addRow() unless $rows.children().length
  }
]

@app.directive 'repeaterRow', ->
  {
    restrict: 'A'
    scope: true
    link: ($scope, $el, $attrs) ->
      $scope.removeRow = ->
        $el.remove()
        true
  }
