<template>
  <div class="pa4 bb b--base-gray">
    <div class="dt w-100">
      <div class="dtc v-mid">
        <div class="dtc v-mid pr4" v-if="backTo">
          <router-link :to="backTo" class="el-button primary hover-blue-dark el-button--default">
            <i class="el-icon-arrow-left"></i>
            <span>Back</span>
          </router-link>
        </div>
        <div class="dtc v-mid">
          <h1 class="ma0 f3 fw3 lh-block light-black">{{ title }}</h1>
        </div>
      </div>
      <div class="dtc v-mid tr">
        <slot></slot>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    backTo: null,
    title: {
      type: String,
      required: true
    }
  }
}
</script>
