<template>
  <div>
    <top-bar :title="title">
      <router-link :to="{ name: 'new_asset' }" class="el-button el-button--primary">New asset</router-link>
    </top-bar>

    <div class="pa4">
      MEDIA CARDS
    </div>

    <debug :object="{meta, assets}" />
  </div>
</template>

<script>
import Controller from './../../mixins/controller.js'

export default {
  mixins: [Controller],

  data() {
    return {
      meta: null,
      assets: null
    }
  },

  computed: {
    title() {
      return 'All media'
    }
  },
  
  methods: {
    resetData() {
      this.meta = this.assets = null;
    },
    loadData() {
      this.apiGet('/media', data => {
        this.meta = data.meta;
        this.assets = data.assets;
      });
    }
  }
}
</script>