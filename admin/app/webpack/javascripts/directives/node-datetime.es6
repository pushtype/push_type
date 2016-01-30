import Vue from 'vue';
import $ from 'jquery';

export default Vue.directive('node-datetime', {
  twoWay: true,
  bind: function() {
    let self = this;
    $(this.el).on('change', function(e) {
      let dateArray = $(this).siblings('select').andSelf().map(function() { return $(this).val(); }).get();
      dateArray[1]--;
      self.set(dateArray);
    })
  }
})