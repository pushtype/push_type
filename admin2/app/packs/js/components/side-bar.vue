<template>
  <div class="absolute left-0 top-0 bottom-0 w5 white bg-light-black">
    <div class="pa4">
      <h1 class="di ma0 mr1 f3 lh-copy"><span class="fw9">Push</span><span class="fw3">Type</span></h1>
      <span class="f7 fw3 light-silver">v0.10.2</span>
    </div>
  
    <ul class="ma0 pa0 list f6 lh-title">
      <li><router-link :to="{ name: 'nodes' }" class="db ph4 pv3 link extra-light-silver hover-white bg-animate hover-bg-extra-light-black">Nodes</router-link></li>
      <li><router-link :to="{ name: 'assets' }" class="db ph4 pv3 link extra-light-silver hover-white bg-animate hover-bg-extra-light-black">Assets</router-link></li>
      <li><router-link :to="{ name: 'users' }" class="db ph4 pv3 link extra-light-silver hover-white bg-animate hover-bg-extra-light-black">Users</router-link></li>
    </ul>
  </div>
</template>

<script>
export default {
  
}
</script>
