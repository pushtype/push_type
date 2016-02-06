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
#= require ./webpack/admin.bundle
#= require jquery_ujs
#= require turbolinks
#= require foundation/foundation
#= require foundation
#= require confirm_with_reveal
#= require jquery.filedrop
#= require jquery.simplePagination
#= require selectize
#= require pickadate/picker
#= require pickadate/picker.date
#= require pickadate/picker.time
#= require froala_editor.min
#= require ./wysiwyg_setup
#= require ./vue_setup
#= require_tree ./wysiwyg
#= require_self

Turbolinks.enableProgressBar()

Math.uid = -> Math.floor(Math.random()*16777215).toString(16)

# By default doc is not binded
docBinded = false
# Document should by bound first and only then should
# dynamically added dom nodes be bound
$(document).on 'init.fndtn', (e) ->
  if e.target == document
    $(document).foundation()
    $(document).confirmWithReveal()
    docBinded = true 
  else if docBinded
    $(e.target).foundation()
