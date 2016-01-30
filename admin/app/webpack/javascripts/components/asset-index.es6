import Vue from 'vue';

export default Vue.component('asset-index', {

  props: {
    assets: {
      coerce: (val) => JSON.parse(val)
    },
    editPath: true
  },

  methods: {
    editUrl: function(asset) {
      return this.editPath.replace(/~id/, asset.id);
    },
    afterUpload: function(asset) {
      this.assets.unshift(asset);
      this.assets = this.assets.slice(0, 20);
    }
  }

})