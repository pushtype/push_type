<template>
  <div id="side-panel">
    <ul>
      <li><router-link :to="{ name: 'nodes' }">Nodes</router-link></li>
      <li><router-link :to="{ name: 'assets' }">Assets</router-link></li>
      <li><router-link :to="{ name: 'users' }">Users</router-link></li>
    </ul>
  </div>
</template>

<script>
export default {
  
}
</script>
