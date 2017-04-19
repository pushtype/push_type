<template>
  <div id="users">
    <p>Users</p>
    <router-link :to="{ name: 'new_user' }">New user</router-link>
  </div>
</template>

<script>
import ApiClient from './../../mixins/api_client.js'

export default {
  mixins: [ApiClient]
}
</script>