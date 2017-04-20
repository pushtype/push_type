<template>
  <div>
    <top-bar :title="title">
      <router-link :to="{ name: 'new_user' }" class="el-button el-button--primary">New user</router-link>
    </top-bar>

    <div class="pa4">
      USER CARDS
    </div>

    <debug :object="{meta, users}" />
  </div>
</template>

<script>
import Controller from './../../mixins/controller.js'

export default {
  mixins: [Controller],

  data() {
    return {
      meta: null,
      users: null
    }
  },

  computed: {
    title() {
      return 'Users'
    }
  },
  
  methods: {
    resetData() {
      this.meta = this.users = null;
    },
    loadData() {
      this.resetData();
      this.apiGet('/users', data => {
        this.meta = data.meta;
        this.users = data.users;
      });
    }
  }
}
</script>