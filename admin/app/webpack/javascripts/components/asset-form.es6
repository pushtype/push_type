import Vue from 'vue';

export default Vue.component('asset-form', {

  props: {
    asset: {
      coerce: (val) => JSON.parse(val)
    },
    createPath: true,
    updatePath: true
  },

  computed: {
    saveMethod: function() {
      return this.asset['new_record?'] ? 'post' : 'patch';
    },

    saveUrl: function() {
      return this.asset['new_record?'] ? this.createPath : this.updatePath.replace(/~id$/, this.asset.id);
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