<template>
  <div class="absolute bottom-0 left-0 right-0 pl7">
    <div class="pa4">
      <el-button @click="toggleDisplay()" v-show="!display">{{ label }}</el-button>  
      <pre class="h5 ma0 pa3 f7 lh-copy dark-white bg-extra-light-black br2 pre" v-show="display"><div v-for="obj, key in object">{{ key }}: {{ obj }}</div></pre>
    </div>
  </div>
  
</template>

<script>
export default {
  props: ['object'],

  data() {
    return {
      display: false
    }
  },

  computed: {
    label() {
      return this.display ? 'Hide debug' : 'Show debug' ;
    }
  },

  methods: {
    toggleDisplay() {
      this.display = !this.display;
    }
  }
}
</script>