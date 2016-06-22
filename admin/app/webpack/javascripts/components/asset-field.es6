import Vue from 'vue';
import AssetModal from './asset-modal.vue';

export default Vue.component('asset-field', {

  props: {
    asset: {
      coerce: (val) => JSON.parse(val)
    }
  },

  data: function() {
    return {
      uid: `asset-${ Math.uid() }`
    }
  },

  ready: function() {
    if (window.fndtnInit) {
      setTimeout(() => $(this.$el).trigger('init.fndtn'), 100);
    }
  },

  computed: {
    assetId: function() {
      return this.asset ? this.asset.id : null;
    }
  },

  methods: {
    selectAsset: function(asset) {
      this.asset = asset;
    },
    deselectAsset: function() {
      this.asset = null;
    }
  },

  components: {
    'asset-modal': AssetModal
  }

})