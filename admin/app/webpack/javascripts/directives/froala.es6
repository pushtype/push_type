import Vue from 'vue';
import $ from 'jquery';

export default Vue.directive('froala', {
  params: ['upload-path'],

  bind: function() {
    let $el = $(this.el);
    $el.on('froalaEditor.initialized',  (e, editor) => {
      this.vm.$editor = editor;
    });
    $el.on('froalaEditor.focus',        (e, editor) => editor.$box.addClass('focus') );
    $el.on('froalaEditor.blur',         (e, editor) => editor.$box.removeClass('focus') );
    $el.on('froalaEditor.image.error',  (e, editor, error) => alert(error.message) );

    setTimeout(() => {
      $el.froalaEditor({
        toolbarButtons: ['bold', 'italic', 'underline', '|', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'insertTable', '|', 'insertLink', 'insertImage', 'insertVideo', '|', 'undo', 'redo', 'clearFormatting', 'fullscreen', '|', 'html'],
        paragraphFormat: {
          n:  'Normal',
          h2: 'Heading 2',
          h3: 'Heading 3',
          h4: 'Heading 4',
          blockquote: 'Quote',
          pre: 'Code'
        },
        height: 400,
        codeBeautifier: true,
        codeMirror: true,
        imageUploadURL: this.params.uploadPath,
        imageUploadParam: 'asset[file]',
        theme: 'gray'
      })
    }, 150);
  }
})