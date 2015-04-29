@app.controller 'RepeaterFieldCtrl',  ['$scope', ($scope) ->

  $scope.rows = [$scope.obj]

  $scope.initRows = (rows) ->
    $scope.rows = rows if rows? && rows.length

  $scope.addRow = ->
    $scope.rows.push $scope.obj

  $scope.removeRow = (i) ->
    $scope.rows.splice(i, 1);

]