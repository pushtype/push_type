<template>
  <div>
    <top-bar :title="title" :backTo="{ name: 'assets' }" />

    <div class="pa4">
      <p>FORM</p>
    </div>

    <debug :object="{asset}" />
  </div>
</template>

<script>
import Controller from './../../mixins/controller.js'

export default {
  mixins: [Controller],

  data() {
    return {
      asset: {}
    }
  },

  computed: {
    title() {
      return 'New media';
    }
  }
}
</script>