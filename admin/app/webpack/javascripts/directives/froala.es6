import Vue from 'vue';
import $ from 'jquery';
import _ from 'lodash';

const defaults = {
  toolbarButtons: ['bold', 'italic', 'underline', '|', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'insertTable', '|', 'insertLink', 'insertImage', 'insertVideo', 'insertFile', '|', 'undo', 'redo', 'clearFormatting', 'fullscreen', '|', 'html'],
  toolbarButtonsMD: ['bold', 'italic', 'underline', '|', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'insertTable', '|', 'insertLink', '|', 'undo', 'redo', 'clearFormatting', '|', 'html'],
  toolbarButtonsSM: ['bold', 'italic', 'underline', '|', 'insertLink', '|', 'undo', 'redo', 'clearFormatting'],
  toolbarButtonsXS: ['bold', 'italic', 'underline', '|', 'insertLink', '|', 'undo', 'redo', 'clearFormatting'],
  paragraphFormat: {
    n:  'Normal',
    h2: 'Heading 2',
    h3: 'Heading 3',
    h4: 'Heading 4',
    blockquote: 'Quote',
    pre: 'Code'
  },
  codeMirror: true,
  height: 400,
  theme: 'gray'
}

const opts = {
  full: {
    toolbarButtons: ['bold', 'italic', 'underline', '|', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'insertTable', '|', 'insertLink', 'insertImage', 'insertVideo', 'insertFile', '|', 'undo', 'redo', 'clearFormatting', 'fullscreen', '|', 'html'],
    toolbarButtonsMD: ['bold', 'italic', 'underline', '|', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'insertTable', '|', 'insertLink', '|', 'undo', 'redo', 'clearFormatting', '|', 'html'],
  },
  text: {
    toolbarButtons: ['bold', 'italic', 'underline', '|', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'insertTable', '|', 'insertLink', '|', 'undo', 'redo', 'clearFormatting', '|', 'html'],
    toolbarButtonsMD: ['bold', 'italic', 'underline', '|', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'insertTable', '|', 'insertLink', '|', 'undo', 'redo', 'clearFormatting', '|', 'html'],
    height: 300,
  },
  mini: {
    toolbarButtons: ['bold', 'italic', 'underline', '|', 'insertLink', '|', 'undo', 'redo', 'clearFormatting', '|', 'html'],
    toolbarButtonsMD: ['bold', 'italic', 'underline', '|', 'insertLink', '|', 'undo', 'redo', 'clearFormatting', '|', 'html'],
    height: 200
  }
}

export default Vue.directive('froala', {
  params: ['froala-toolbar'],

  bind: function() {
    let $el = $(this.el);
    $el.on('froalaEditor.initialized',  (e, editor) => this.vm.$editor = editor );
    $el.on('froalaEditor.focus',        (e, editor) => editor.$box.addClass('focus') );
    $el.on('froalaEditor.blur',         (e, editor) => editor.$box.removeClass('focus') );
    $el.on('froalaEditor.image.error',  (e, editor, error) => alert(error.message) );

    let uploadPath = `${ PushType.Routes.adminPath }/media/upload`;

    let options = {};
    _.extend(options, defaults, opts[this.params.froalaToolbar], {
      fileUploadURL:  uploadPath,
      imageUploadURL: uploadPath
    })

    setTimeout(() => { $el.froalaEditor(options) }, 200);
  }
})