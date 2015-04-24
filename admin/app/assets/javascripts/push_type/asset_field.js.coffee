@app.controller 'AssetFieldCtrl',  ['$scope', '$http', ($scope, $http) ->

  $scope.$modal = null
  $scope.assets = []
  
  $scope.loadAssets = ->
    req = $http.get $scope.assetsPath
    req.success (data) ->
      $scope.assets = data.assets

  $scope.selectAsset = (asset) ->
    $scope.asset = asset
    $scope.$modal.foundation 'reveal', 'close'
    true

  $scope.deselectAsset = ->
    $scope.asset = null

]


# jQuery init
$(document).on 'ready page:load', ->

  $(document).on 'open.fndtn.reveal', '.asset-field-modal', ->
    $scope  = angular.element($(this)).scope()
    $scope.$modal = $(this)
    $scope.loadAssets()
    $scope.$apply()
      
      
