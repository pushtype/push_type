<template>
  <div>
    <top-bar :title="title" :backTo="{ name: 'assets' }" />
    
    <div class="pa4">
      <p>FORM</p>
    </div>

    <debug :object="{meta, asset}" />
  </div>
</template>

<script>
import Controller from './../../mixins/controller.js'

export default {
  mixins: [Controller],
  props: ['id'],

  data() {
    return {
      meta: null,
      asset: null
    }
  },

  computed: {
    title() {
      return 'Edit asset';
    }
  },
  
  methods: {
    loadData() {
      this.apiGet('/media/:id', data => {
        this.meta = data.meta;
        this.asset = data.asset;
      });
    }
  }
}
</script>