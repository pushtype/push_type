<template>
  <div>
    <top-bar :title="title" :backTo="{ name: 'users' }" />
    
    <div class="pa4">
      <p>FORM</p>
    </div>

    <debug :object="{meta, user}" />
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
      user: null
    }
  },

  computed: {
    title() {
      return 'Edit user';
    }
  },
  
  methods: {
    loadData() {
      this.apiGet('/users/:id', data => {
        this.meta = data.meta;
        this.user = data.user;
      });
    }
  }
}
</script>