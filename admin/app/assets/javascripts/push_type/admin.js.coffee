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
#= require foundation
#= require confirm_with_reveal
#= require angular
#= require jquery.sticky
#= require jquery.sortable
#= require jquery.filedrop
#= require moment
#= require_self
#= require bootstrap-tagsinput
#= require_tree .

Turbolinks.enableProgressBar()

@app = angular.module 'push_type', []

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

  $('.sortable').sortable
    handle: '.handle'
    forcePlaceholderSize: true
  .on 'sortupdate', (e, ui) ->
    obj = { prev: ui.item.prev().data('id'), next: ui.item.next().data('id') }
    $.post "/push_type/nodes/#{ ui.item.data('id') }/position", obj, 'json'

  $(document).confirmWithReveal()

  $('.tagsinput', '.tags').tagsinput
    tagClass: 'label secondary radius'
    

