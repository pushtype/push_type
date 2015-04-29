@app.controller 'MatrixFieldCtrl',  ['$scope', ($scope) ->

  $scope.rows = [{}]

  $scope.initRows = (rows) ->
    $scope.rows = rows if rows?

  $scope.addRow = ->
    $scope.rows.push {}

  $scope.removeRow = (i) ->
    console.log "Removeing #{i}" 
    $scope.rows.splice(i, 1);

]