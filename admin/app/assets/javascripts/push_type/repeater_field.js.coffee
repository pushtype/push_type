@app.controller 'RepeaterFieldCtrl',  ['$scope', ($scope) ->

  $scope.rows = ['']

  $scope.initRows = (rows) ->
    $scope.rows = rows if rows? && rows.length

  $scope.addRow = ->
    $scope.rows.push ''

  $scope.removeRow = (i) ->
    $scope.rows.splice(i, 1);

]