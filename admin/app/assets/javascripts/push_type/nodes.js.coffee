@app.controller 'NodeFormCtrl', ['$scope', ($scope) ->

  $scope.typeToString = ->
    $scope.node.type.replace( /([A-Z])/g, (m) -> " #{ m.toLowerCase() }" ).trim()

  $scope.setSlug = ->
    if $scope.node['new_record?']
      $scope.node.slug = $scope.node.title.toLowerCase().replace(/[\s\_]/g, '-').replace(/[^\w\-]/g, '')

  $scope.permalinkVisibility = ->
    if $scope.node.slug? then 'visible' else null

  $scope.saveButtonClass = ->
    if $scope.node.status == 'published' then 'success' else 'primary'

  $scope.saveButtonText = ->
    switch $scope.node.status
      when 'draft'
        if $scope.node['new_record?'] || !$scope.node.published_at?
          'Save draft'
        else
          "Unpublish #{ $scope.typeToString() }"
      when 'published'
        if $scope.node['new_record?'] || !$scope.node.published_at?
          if $scope.publishedAtMoment().toDate() > new Date() then 'Publish later' else 'Publish now'
        else
          "Save #{ $scope.typeToString() }"
          

  $scope.publishedDates = ->
    switch $scope.node.status
      when 'draft'
        'N/A'
      when 'published'
        if $scope.node['new_record?'] || !$scope.node.published_at?
          if $scope.publishedAtMoment().toDate() > new Date() then $scope.publishedAtMoment().format('Do MMM YYYY, h:mma') else 'Immediately'
        else
          $scope.publishedAtMoment().format('Do MMM YYYY, h:mma')
          

  $scope.publishedAtMoment = ->
    $scope.published_at ||= if $scope.node.published_at then moment($scope.node.published_at) else moment()

]

@app.directive 'nodeStatus', ->
  (scope, $el, attrs) ->
    $el.on 'click', (e) ->
      e.preventDefault()
      scope.node.status = attrs.nodeStatus
      $(this).foundation 'dropdown', 'close', $(this).parents('.f-dropdown')
      scope.$apply() unless scope.$$phase

@app.directive 'nodeDatetime', ->
  (scope, $el, attrs) ->
    $el.on 'change', (e) ->
      dateArray = $(this).siblings('select').andSelf().map( -> $(this).val() ).get()
      dateArray[1]--
      scope[attrs.nodeDatetime] = moment(dateArray)
      scope.$apply() unless scope.$$phase