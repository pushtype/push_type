<template>
  <div>
    <top-bar :title="title" :backTo="backToLinkOpts" />

    <div class="pa4">
      <p>FORM</p>
    </div>

    <debug :object="{node}" />
  </div>
</template>

<script>
import Controller from './../../mixins/controller.js'

export default {
  mixins: [Controller],
  props: ['node_id'],

  data() {
    return {
      node: {}
    }
  },

  computed: {
    title() {
      return 'New node';
    },
    backToLinkOpts() {
      return this.node_id ? { name: 'node_nodes', params: { node_id: this.node_id } } : { name: 'nodes' };
    }
  }
}
</script>