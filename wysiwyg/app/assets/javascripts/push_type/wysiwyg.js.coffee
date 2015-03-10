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
#= require froala_editor.min
#= require plugins/lists.min
#= require plugins/tables.min
#= require plugins/file_upload.min
#= require plugins/media_manager.min
#= require plugins/video.min
#= require plugins/fullscreen.min
#= require jquery.simplePagination
#= require_self
#= require_tree .

$.Editable.DEFAULTS.key = 'Tb3QXIa1QZh1UOXATEX==';

# jQuery init
$(document).on 'ready page:load', ->

  $('textarea.froala', '.wysiwyg').editable
    inlineMode:       false
    buttons:          ['bold', 'italic', 'underline', 'sep', 'formatBlock', 'align', 'insertOrderedList', 'insertUnorderedList', 'table', 'sep', 'createLink', 'insertImage', 'uploadFile', 'insertVideo', 'sep', 'undo', 'redo', 'removeFormat', 'fullscreen', 'sep', 'html']
    blockTags:
      n:  'Normal'
      h2: 'Heading 2'
      h3: 'Heading 3'
      h4: 'Heading 4'
      blockquote: 'Quote'
      pre: 'Code'
    height:             400
    filesLoadURL:       '/push_type/wysiwyg_media'
    filesLoadParams:    { filter: 'file' }
    fileUploadURL:      '/push_type/wysiwyg_media'
    fileUploadParam:    'asset[file]'
    imagesLoadURL:      '/push_type/wysiwyg_media'
    imagesLoadParams:   { filter: 'image' }
    imageUploadURL:     '/push_type/wysiwyg_media'
    imageUploadParam:   'asset[file]'
    theme:              'pt'

  $('textarea.froala', '.wysiwyg').on 'editable.focus', (e, editor) ->
    editor.$box.addClass 'focus'

  $('textarea.froala', '.wysiwyg').on 'editable.blur', (e, editor) ->
    editor.$box.removeClass 'focus'

  $('textarea.froala', '.wysiwyg').on 'editable.imageError', (e, editor, error) ->
    alert error.message