import Vue from 'vue';
import $ from 'jquery';

export default Vue.directive('node-submit', {
  bind: function() {
    let $el = $(this.el);
    $el.on('click', function(e) {
      if ( !$(e.target).is('span') ) {
        $el.parents('form').submit();
      }
    })
  }
})