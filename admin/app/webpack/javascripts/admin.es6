import _ from 'expose?_!lodash';
import $ from 'expose?$!expose?jQuery!jquery';
import Vue from 'expose?Vue!vue';
import vr from 'vue-resource';
Vue.use(vr);

// Components
import './components/node-form.es6';
import './components/asset-index.es6';
import './components/asset-form.es6';
import './components/asset-field.es6';
import './components/repeater-field.es6';
import './components/wysiwyg-field.es6';

// Directives
import './directives/side-panel.es6';
import './directives/node-datetime.es6';
import './directives/node-submit.es6';
import './directives/asset-upload.es6';
import './directives/pickadate.es6';
import './directives/selectize.es6';
import './directives/froala.es6';
import './directives/code-mirror.es6';
import './directives/simple-pagination.es6';

// Filters
import './filters/kb.es6';

// jQuery dependencies
import 'html5sortable';
import 'jquery-sticky';

// Set this variable on the window object
// use it to tell if foundation has been init
window.fndtnInit = false;

const app = {
  el: '[role="main"]',
  ready: function() {
    setTimeout(() => {
      $(document).trigger('init.fndtn');
      window.fndtnInit = true;
    }, 250);
  }
}

$(document).on('ready page:load turbolinks:load', function() {
  window.fndtnInit = false;
  new Vue(app);

  $('.node-list.sortable').sortable({
    handle: '.handle',
    forcePlaceholderSize: true
  }).on('sortupdate', function(e, ui) {
    $.post(`${ PushType.Routes.adminPath }/nodes/${ ui.item.data('id') }/position`, {
      prev: ui.item.prev().data('id'),
      next: ui.item.next().data('id')
    }, 'json');
  })
})
