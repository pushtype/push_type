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
      if (asset['image?']) {
        this.$editor.image.insert(asset.url, false, {}, $current_image);
      } else {
        this.$editor.file.insert(asset.url, asset.description_or_file_name);
      }
    },
  },

  components: {
    'asset-modal': AssetModal
  }
})