import Vue from 'vue';
import $ from 'jquery';

const opts = {
  date: {
    format: 'd mmmm yyyy',
    formatSubmit: 'yyyy-mm-dd',
    hiddenName: true
  },  
  time: {
    format: 'h:i A',
    formatSubmit: 'HH:i',
    formatLabel: 'h:i A <sm!all>HH:i</sm!all>',
    hiddenName: true
  }
}

export default Vue.directive('pickadate', {
  params: ['pickadate-kind'],
  bind: function() {
    switch(this.params.pickadateKind) {
      case 'date':
        $(this.el).pickadate(opts.date);
        break;
      case 'time':
        $(this.el).pickatime(opts.time);
        break;
    }
  }
})