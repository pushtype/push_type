<template>
  <div id="assets">
    <p>Assets</p>
    <router-link :to="{ name: 'new_asset' }">New asset</router-link>
  </div>
</template>

<script>
import ApiClient from './../../mixins/api_client.js'

export default {
  mixins: [ApiClient]
}
</script>