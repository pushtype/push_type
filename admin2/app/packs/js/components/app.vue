<template>
  <div id="app">
    <side-panel></side-panel>
    <hr>
    <router-view></router-view>
  </div>
</template>

<script>
import SidePanel from './side-panel.vue'

export default {
  props: ['apiPath'],

  created() {
    this.PushType.apiBasePath = this.apiPath;
  },
  
  components: {
    SidePanel
  }
}
</script>
