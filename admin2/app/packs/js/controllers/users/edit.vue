<template>
  <div id="user">
    <p>Edit user</p>
  </div>
</template>

<script>
import ApiClient from './../../mixins/api_client.js'

export default {
  mixins: [ApiClient],
  props: ['node_id'],

}
</script>