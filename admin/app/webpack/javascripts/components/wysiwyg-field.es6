import Vue from 'vue';
import AssetModal from './asset-modal.vue';

export default Vue.component('wysiwyg-field', {

  data: function() {
    return {
      uid: `wysiwyg-${ Math.uid() }`,
      $editor: null
    }
  },

  methods: {
    selectAsset: function(asset) {
      let $current_image = this.$editor.$current_image;
      this.$editor.image.insert(asset.preview_thumb_url, false, {}, $current_image);
    },
  },

  components: {
    'asset-modal': AssetModal
  }
})