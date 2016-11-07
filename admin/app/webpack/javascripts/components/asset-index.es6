import Vue from 'vue';

export default Vue.component('asset-index', {

  props: {
    assets: {
      coerce: (val) => JSON.parse(val)
    }
  },

  methods: {
    editUrl: function(asset) {
      return `${ PushType.Routes.adminPath }/media/${ asset.id }/edit`;
    },
    afterUpload: function(asset) {
      this.assets.unshift(asset);
      this.assets = this.assets.slice(0, 20);
    }
  }

})