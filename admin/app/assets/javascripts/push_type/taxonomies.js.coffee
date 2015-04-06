@app.controller 'TaxonomyTermsCtrl', ['$scope', '$http', ($scope, $http) ->

  $scope.basePath = location.pathname + '/terms'

  $scope.termCount = ->
    $scope.terms.length

  $scope.newTerm = ->
    $scope.terms.push { children: [] }

  $scope.treeFuncs = {
    accept: (sourceNodeScope, destNodesScope) ->
      term = sourceNodeScope.term
      matches = $.grep destNodesScope.terms, (i) ->
        i.id != term.id && ( i.title == term.title || i.slug == term.slug )
      if matches.length then false else true
    dropped: (e) ->
      # Unless node is dropped in exactly the same position
      unless e.source.index == e.dest.index && e.source.nodesScope == e.dest.nodesScope
        term   = e.source.nodeScope.term
        parent = e.dest.nodesScope.term
        index  = e.dest.index
        family = if parent? then parent.children else e.dest.nodesScope.terms or e.source.nodeScope.terms
        obj =
          prev:   if family[index-1]? then family[index-1].id else null
          next:   if family[index+1]? then family[index+1].id else null
          parent: if parent? then parent.id else null
        url = "#{ $scope.basePath }/#{ term.id }/position"
        req = $http.post url, obj
  }

]

@app.controller 'TaxonomyTermCtrl', ['$scope', '$http', ($scope, $http) ->

  $scope.master = {}

  $scope.errors = {}

  $scope.isEditing = ->
    $scope.isNewTerm() || $scope.termForm.$dirty

  $scope.edit = ->
    $scope.master = angular.copy($scope.term)
    $scope.termForm.$setDirty()

  $scope.reset = ->
    # We need to reset the slug to force child nodes to
    # update permalink
    $scope.term.slug = $scope.master.slug
    $scope.term = angular.copy($scope.master)
    $scope.termForm.$setPristine()
    if $scope.isNewTerm()
      $scope.popTerm($scope.term)

  $scope.popTerm = (term) ->
    idx = $.inArray(term, $scope.terms)
    $scope.terms.splice(idx, 1);

  $scope.save = ->
    params = {}
    params[$scope.param] = $scope.term

    req = if $scope.isNewTerm()
      $http.post $scope.basePath, params
    else
      url = $scope.basePath + '/' + $scope.term.id
      $http.put url, params

    req.success (data) ->
      $scope.term.id = data.term.id if $scope.isNewTerm()
      $scope.termForm.$setPristine()
    req.error (data, status) ->
      for field, error of data.errors
        $scope.errors[field] = error[0]
        $scope.termForm[field].$valid = false

  $scope.delete = ->
    url = $scope.basePath + '/' + $scope.term.id
    $http.delete url
    $scope.popTerm($scope.term)

  $scope.setSlug = ->
    if $scope.isNewTerm()
      $scope.term.slug = $scope.term.title.toLowerCase().replace(/[\s\_]/g, '-').replace(/[^\w\-]/g, '')

  $scope.errorClass = (field) ->
    if $scope.errors[field] then 'error' else null

  $scope.isNewTerm = ->
    angular.isUndefined($scope.term.id)

  $scope.termPermalink = ->
    path = [$scope.baseSlug]
    addParents = (scope) ->
      if scope.$parentNodeScope?
        addParents(scope.$parentNodeScope)
        path.push scope.$parentNodeScope.term.slug
    addParents($scope)
    path.push $scope.term.slug
    '/' + path.join('/')

]
