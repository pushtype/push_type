import Vue from 'vue';

const opts = {
  'markdown': {
    mode:           'gfm',
    lineNumbers:    false,
    matchBrackets:  true,
    lineWrapping:   true,
    theme:          'base16-light',
    extraKeys: {
      'Enter': 'newlineAndIndentContinueMarkdownList'
    }
  }
}

export default Vue.directive('code-mirror', {
  params: ['code-mirror-mode'],
  bind: function() {
    setTimeout(() => { CodeMirror.fromTextArea(this.el, opts[this.params.codeMirrorMode]) }, 50)
  }
})
