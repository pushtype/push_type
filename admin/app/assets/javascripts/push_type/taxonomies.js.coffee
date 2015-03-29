@app.controller 'TaxonomyItemsCtrl', ['$scope', '$http', ($scope, $http) ->

  $scope.basePath = location.pathname + '/items'

  $scope.itemCount = ->
    $scope.items.length

  $scope.newItem = ->
    $scope.items.push { children: [] }

  $scope.treeFuncs = {
    accept: (sourceNodeScope, destNodesScope) ->
      item = sourceNodeScope.item
      matches = $.grep destNodesScope.items, (i) ->
        i.id != item.id && ( i.title == item.title || i.slug == item.slug )
      if matches.length then false else true
    dropped: (e) ->
      # Unless node is dropped in exactly the same position
      unless e.source.index == e.dest.index && e.source.nodesScope == e.dest.nodesScope
        item   = e.source.nodeScope.item
        parent = e.dest.nodesScope.item
        index  = e.dest.index
        family = if parent? then parent.children else e.dest.nodesScope.items or e.source.nodeScope.items
        obj =
          prev:   if family[index-1]? then family[index-1].id else null
          next:   if family[index+1]? then family[index+1].id else null
          parent: if parent? then parent.id else null
        url = "#{ $scope.basePath }/#{ item.id }/position"
        req = $http.post url, obj
  }

]

@app.controller 'TaxonomyItemCtrl', ['$scope', '$http', ($scope, $http) ->

  $scope.master = {}

  $scope.errors = {}

  $scope.isEditing = ->
    $scope.isNewItem() || $scope.itemForm.$dirty

  $scope.edit = ->
    $scope.master = angular.copy($scope.item)
    $scope.itemForm.$setDirty()

  $scope.reset = ->
    $scope.item = angular.copy($scope.master)
    $scope.itemForm.$setPristine()
    if $scope.isNewItem()
      $scope.popItem($scope.item)

  $scope.popItem = (item) ->
    idx = $.inArray(item, $scope.items)
    $scope.items.splice(idx, 1);

  $scope.save = ->
    params = {}
    params[$scope.param] = $scope.item

    req = if $scope.isNewItem()
      $http.post $scope.basePath, params
    else
      url = $scope.basePath + '/' + $scope.item.id
      $http.put url, params

    req.success (data) ->
      $scope.item.id = data.id if $scope.isNewItem()
      $scope.itemForm.$setPristine()
    req.error (data, status) ->
      for field, error of data
        $scope.errors[field] = error[0]
        $scope.itemForm[field].$valid = false
      console.log $scope.errors

  $scope.delete = ->
    url = $scope.basePath + '/' + $scope.item.id
    $http.delete url
    $scope.popItem($scope.item)

  $scope.setSlug = ->
    if $scope.isNewItem()
      $scope.item.slug = $scope.item.title.toLowerCase().replace(/[\s\_]/g, '-').replace(/[^\w\-]/g, '')

  $scope.errorClass = (field) ->
    if $scope.errors[field] then 'error' else null

  $scope.isNewItem = ->
    angular.isUndefined($scope.item.id)

  $scope.itemPermalink = ->
    $scope.slugBase + '/' + $scope.item.slug

]

