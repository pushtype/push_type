<template>
  <div>
    <top-bar :title="title" :backTo="backToLinkOpts">
      <router-link :to="newNodeLinkOpts" class="el-button el-button--primary">New node</router-link>
    </top-bar>

    <div class="pa4">
      <div class="pv3 bt bb b--extra-light-gray" v-for="node in nodes">
        <router-link :to="{ name: 'edit_node', params: { id: node.id }}">{{ node.title }}</router-link>
        //
        <router-link :to="{ name: 'node_nodes', params: { node_id: node.id } }">{{ node.children }} children</router-link>
      </div>
    </div>

    <debug :object="{meta, nodes, parent}" />
  </div>
</template>

<script>
import _ from 'lodash'
import Controller from './../../mixins/controller.js'

export default {
  mixins: [Controller],
  props: ['node_id'],
  
  data() {
    return {
      meta: null,
      nodes: null,
      parent: null
    }
  },

  computed: {
    title() {
      if (this.parent) {
        return this.parent.title;
      } else {
        return 'All content';
      }
    },
    backToLinkOpts() {
      if (this.parent) {
        return this.parent.parent_id ? { name: 'node_nodes', params: { node_id: this.parent.parent_id } } : { name: 'nodes' };
      } else {
        return undefined;
      }
    },
    newNodeLinkOpts() {
      if (this.node_id) {
        return { name: 'new_node_node', params: { node_id: this.node_id } };
      } else {
        return { name: 'new_node' };
      }
    }
  },
  
  methods: {
    resetData() {
      this.meta = this.nodes = this.parent = null;
    },
    loadData() {
      let params = (this.node_id ? { node_id: this.node_id } : undefined);
      this.apiGet('/nodes', params, data => {
        this.meta = data.meta;
        this.nodes = data.nodes;
      });
      if (this.node_id) {
        this.apiGet('/nodes/:node_id', data => this.parent = data.node);
      }
    }
  }
}
</script>
