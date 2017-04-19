<template>
  <div id="node">
    <p>Edit node</p>

    <pre style="white-space: pre-line;">
      META:
      {{ meta }}
      NODE:
      {{ node }}
    </pre>
  </div>
</template>

<script>
import ApiClient from './../../mixins/api_client.js'

export default {
  mixins: [ApiClient],
  props: ['id'],

  data() {
    return {
      meta: null,
      node: null
    }
  },

  created() {
    this.loadData();
  },

  watch: {
    '$route': 'loadData'
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