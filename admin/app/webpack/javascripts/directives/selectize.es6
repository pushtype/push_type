import Vue from 'vue';
import _ from 'lodash';
import $ from 'jquery';

const opts = {
  select: {
    plugins:      ['remove_button'],
    hideSelected: false
  },
  tag_list: {
    plugins:  ['remove_button', 'drag_drop'],
    create:   true,
    persist:  false,
  },
  relation: {
    plugins:      ['remove_button'],
    hideSelected: false,
    onInitialize: function() {
      let sel     = this,
          options = sel.$input.data('options'),
          items   = sel.$input.data('items');
      _.each(options, o => sel.addOption(o));
      if ( _.isArray(items) ) {
        _.each(items, i => sel.addItem(i));
      } else {
        sel.addItem(items);
      }
    },
    render: {
      option: function(item, esc) {
        let pre = item.depth > 0 ? '- '.repeat(item.depth) : '';
        return `<div class="option">${ pre }${ esc(item.text) }</div>`;
      }
    }
  }
}

export default Vue.directive('selectize', {
  params: ['selectize-kind'],
  bind: function() {
    $(this.el).selectize(opts[this.params.selectizeKind]);
  }
})