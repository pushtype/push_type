import Vue from 'vue';

export default Vue.component('asset-form', {

  props: {
    asset: {
      coerce: (val) => JSON.parse(val)
    }
  },

  computed: {
    createPath: function() {
      return `${ PushType.Routes.adminPath }/media`;
    },

    updatePath: function() {
      return `${ PushType.Routes.adminPath }/media/${ this.asset.id }`;
    },

    saveMethod: function() {
      return this.asset['new_record?'] ? 'post' : 'patch';
    },

    saveUrl: function() {
      return this.asset['new_record?'] ? this.createPath : this.updatePath;
    },

    saveButtonText: function() {
      return this.asset['new_record?'] ? 'Upload file' : 'Update media';
    }
  },

  methods: {
    afterUpload: function(asset) {
      this.asset = asset;
    }
  }
  
})