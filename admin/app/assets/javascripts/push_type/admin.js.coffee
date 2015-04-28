# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require foundation/foundation
#= require foundation
#= require confirm_with_reveal
#= require angular
#= require angular-ui-tree
#= require jquery.sticky
#= require jquery.sortable
#= require jquery.filedrop
#= require jquery.simplePagination
#= require selectize
#= require moment
#= require pickadate/picker
#= require pickadate/picker.date
#= require pickadate/picker.time
#= require_self
#= stub push_type/admin_assets
#= require_tree .

Turbolinks.enableProgressBar()

@app = angular.module 'push_type', ['ui.tree']

@app.run ['$http', ($http) ->
  $http.defaults.headers.common['Accept'] = 'application/json'
  $http.defaults.headers.common['Content-Type'] = 'application/json'
]

@app.directive 'sidePanel', ->
  (scope, $el, attrs) ->
    $el.sticky
      topSpacing:       80
      getWidthFrom:     '.sticky-wrapper'
      responsiveWidth:  true

# jQuery init
$(document).on 'ready page:load', ->

  # Bootstrap foundation
  $(document).foundation()

  # Bootstrap Angular
  angular.bootstrap $('[role="main"]'), ['push_type']

  $('.node-list.sortable').sortable
    handle: '.handle'
    forcePlaceholderSize: true
  .on 'sortupdate', (e, ui) ->
    obj = { prev: ui.item.prev().data('id'), next: ui.item.next().data('id') }
    $.post "/push_type/nodes/#{ ui.item.data('id') }/position", obj, 'json'

  $(document).confirmWithReveal()

  $('input', '.date').pickadate
    format: 'd mmmm yyyy'
    formatSubmit: 'yyyy-mm-dd'
    hiddenName: true

  $('input', '.time').pickatime
    format: 'h:i A'
    formatSubmit: 'HH:i'
    formatLabel: 'h:i A <sm!all>HH:i</sm!all>'
    hiddenName: true

  $('select', '.select').selectize
    plugins:      ['remove_button']
    hideSelected: false

  $('select', '.taxonomy').selectize
    plugins:      ['remove_button']
    hideSelected: false
    onInitialize: ->
      sel     = this
      options = sel.$input.data('options')
      items   = sel.$input.data('items')
      $.each options, -> sel.addOption this
      if $.isArray items
        $.each items, -> sel.addItem this
      else
        sel.addItem items
    render: 
      option: (item, esc) ->
        pre = if item.depth > 0 then '- '.repeat(item.depth) else ''
        """<div class="option">#{ pre }#{ esc item.text }</div>"""

  $('select', '.tag_list').selectize
    plugins:  ['remove_button', 'drag_drop']
    create:   true
    persist:  false
    

