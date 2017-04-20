<template>
  <div>
    <top-bar :title="title" :backTo="{ name: 'users' }" />

    <div class="pa4">
      <p>FORM</p>
    </div>

    <debug :object="{user}" />
  </div>
</template>

<script>
import Controller from './../../mixins/controller.js'

export default {
  mixins: [Controller],
  
  data() {
    return {
      user: {}
    }
  },

  computed: {
    title() {
      return 'New user';
    }
  }

}
</script>