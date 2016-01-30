import Vue from 'vue';
import $ from 'jquery';

export default Vue.directive('side-panel', {
  bind: function() {
    $(this.el).sticky({
      topSpacing:       80,
      getWidthFrom:     '.sticky-wrapper',
      responsiveWidth:  true
    })
  }
})