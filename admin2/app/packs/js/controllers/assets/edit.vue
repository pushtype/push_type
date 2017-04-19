<template>
  <div id="asset">
    <p>Edit asset</p>
  </div>
</template>

<script>
import ApiClient from './../../mixins/api_client.js'

export default {
  mixins: [ApiClient],
  props: ['id']
}
</script>