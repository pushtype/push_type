<template>
  <div class="relative vh-100 base-black">
    <side-bar></side-bar>
    <div class="pl7">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import SideBar from './side-bar.vue'

export default {
  props: ['apiPath'],

  created() {
    this.PushType.apiBasePath = this.apiPath;
  },
  
  components: {
    SideBar
  }
}
</script>
