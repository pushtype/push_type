import Vue from 'vue';
import $ from 'jquery';

export default Vue.component('repeater-field', {

  props: {
    rowCount: {
      type: Number
    }
  },

  data: function() {
    return {
      rows: []
    }
  },

  created: function() {
    if (this.rowCount === 0) {
      this.addRow();
    }
  },

  methods: {
    addRow: function() {
      this.rows.push({ id: Math.uid() });
    },
    removeRow: function(row) {
      this.rows.$remove(row);
    }
  },

  directives: {
    removeRow: {
      bind: function() {
        $(this.el).on('click', function(e) {
          e.preventDefault();
          $(this).closest('tr').remove();
        })
      }
    }
  }

})