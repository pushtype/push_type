/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %>
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'
import axios from 'axios'

Vue.use(VueRouter);
Vue.prototype.$http = axios;

import PushType from './push_type.js'
Vue.prototype.PushType = PushType;

import routes from './routes.js'
import App from './components/app.vue'

const router = new VueRouter({
  mode: 'history',
  base: 'admin',
  routes
})

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: '#app',
    components: { App },
    router
  })
})