<template>
  <div>
    <top-bar :title="title" :backTo="backToLinkOpts" />
    
    <div class="pa4">
      <p>FORM</p>
    </div>

    <debug :object="{meta, node}" />
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
      node: null
    }
  },

  computed: {
    title() {
      return 'Edit node';
    },
    backToLinkOpts() {
      return this.node && this.node.parent_id ? { name: 'node_nodes', params: { node_id: this.node.parent_id } } : { name: 'nodes' };
    }
  },
  
  methods: {
    loadData() {
      this.apiGet('/nodes/:id', data => {
        this.meta = data.meta;
        this.node = data.node;
      });
    }
  }
}
</script>