<template>
  <div id="nodes">
    <router-link :to="newNodeLinkOpts">New node</router-link>
    <ul>
      <li v-for="node in nodes">
        <router-link :to="{ name: 'node', params: { id: node.id } }">{{ node.title }}</router-link> //
        <router-link :to="{ name: 'node_nodes', params: { node_id: node.id } }">{{ node.children }} children</router-link>
      </li>
    </ul>

    <pre style="white-space: pre-line;">
      META:
      {{ meta }}
      NODES:
      {{ nodes }}
    </pre>
  </div>
</template>

<script>
import _ from 'lodash'
import ApiClient from './../../mixins/api_client.js'

export default {
  mixins: [ApiClient],
  props: ['node_id'],
  
  data() {
    return {
      meta: null,
      nodes: null
    }
  },

  created() {
    this.loadData();
  },

  watch: {
    '$route': 'loadData'
  },

  computed: {
    newNodeLinkOpts() {
      if (this.node_id) {
        return { name: 'new_node_node', params: { node_id: this.node_id } };
      } else {
        return { name: 'new_node' };
      }
    }
  },
  
  methods: {
    loadData() {
      let params = (this.node_id ? { node_id: this.node_id } : undefined);
      this.apiGet('/nodes', params, data => {
        this.meta = data.meta;
        this.nodes = data.nodes;
      });
    }
  }
}
</script>
