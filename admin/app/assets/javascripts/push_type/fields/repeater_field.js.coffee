@app.controller 'RepeaterFieldCtrl',  ['$scope', ($scope) ->

  $scope.rows = [null]

  $scope.initRows = (rows) ->
    $scope.rows = rows if rows?

  $scope.addRow = ->
    $scope.rows.push null

  $scope.removeRow = (i) ->
    console.log "Removeing #{i}" 
    $scope.rows.splice(i, 1);

]