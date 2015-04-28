@app.controller 'AssetFieldCtrl',  ['$scope', '$http', ($scope, $http) ->

  $scope.$modal = null
  $scope.assets = []
  $scope.meta   = {}
  
  $scope.loadAssets = (page) ->
    config = if page? then { params: { page: page } } else null
    req = $http.get $scope.assetsPath, config
    req.success (data) ->
      $scope.assets = data.assets
      $scope.meta   = data.meta
      $scope.initPagination() if $scope.hasAssets()

  $scope.hasAssets = ->
    $scope.assets.length

  $scope.selectAsset = (asset) ->
    $scope.asset = asset
    $scope.$modal.foundation 'reveal', 'close'
    true

  $scope.deselectAsset = ->
    $scope.asset = null

  $scope.afterUpload = (asset) ->
    $scope.loadAssets()
    $scope.$modal.find('.tab-title a[data-success]').trigger 'click'
    true

]

@app.directive 'paginateAssets', ->
  ($scope, $el, $attrs) ->
    $scope.initPagination = ->
      $el.pagination
        pages:          $scope.meta.total_pages
        currentPage:    $scope.meta.current_page
        hrefTextPrefix: '#/media/page-'
        onPageClick: (page, e) ->
          e.preventDefault()
          $scope.loadAssets(page)



# jQuery init
$(document).on 'ready page:load', ->

  $(document).on 'open.fndtn.reveal', '.asset-field-modal', ->
    $scope  = angular.element($(this)).scope()
    $scope.$modal = $(this)
    $scope.loadAssets()
    $scope.$apply()
      
      
