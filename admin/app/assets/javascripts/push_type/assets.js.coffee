@app.controller 'AssetListCtrl',  ['$scope', ($scope) ->

  $scope.assetCount = ->
    $scope.assets.length

  $scope.editUrl = (asset) ->
    $scope.assetUrl.replace(/~id/, asset.id)

  $scope.previewthumbUrl = (asset) ->
    url = asset.preview_thumb_url
    if asset['image?'] then url else asset_path(url)

  $scope.afterUpload = (asset) ->
    $scope.assets.unshift(asset)
    $scope.assets = $scope.assets.slice(0, kaminari_per_page)

]

@app.controller 'AssetUploadCtrl', ['$scope', ($scope) ->

  $scope.method = ->
    if $scope.asset['new_record?'] then 'post' else 'patch'

  $scope.saveUrl = ->
    if $scope.asset['new_record?'] then $scope.createUrl else $scope.updateUrl.replace(/~id$/, $scope.asset.id)

  $scope.saveButtonClass = ->
    if $scope.asset['new_record?'] then 'success' else 'primary'

  $scope.saveButtonText = ->
    if $scope.asset['new_record?'] then 'Upload file' else 'Update media'

  $scope.uploadedDate = ->
    moment($scope.asset.created_at).format('Do MMM YYYY, h:mma')

  $scope.previewthumbUrl = ->
    url = $scope.asset.preview_thumb_url
    if $scope.asset['image?'] then url else asset_path(url)

  $scope.afterUpload = (asset) ->
    $scope.asset = asset

]

@app.directive 'assetUpload', ->
  (scope, $el, attrs) ->
    if attrs.assetFallback
      scope.hideFileField = true
    $el.filedrop
      fallback_id:  attrs.assetFallback
      url:          attrs.assetUpload
      paramname:    'asset[file]'
      maxfiles:     attrs.assetMaxfiles || 1
      dragOver:   -> $(this).addClass('hover')
      dragLeave:  -> $(this).removeClass('hover')
      drop:       -> $(this).removeClass('hover')
      uploadFinished: (i, file, response, time) ->
        scope.afterUpload(response)
        scope.$apply() unless scope.$$phase


