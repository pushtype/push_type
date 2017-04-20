import _ from 'lodash'
import TopBar from '../components/top-bar.vue'
import Debug from '../components/debug.vue'

export default {
  data() {
    return {
      httpLoading:  false,
      httpError:    null
    }
  },

  created() {
    this.loadData();
  },

  watch: {
    '$route': function() {
      this.resetData();
      this.loadData();
    }
  },

  methods: {
    apiGet(url, data, callback) {
      // Shift arguments if data argument was omitted
      if ( _.isFunction(data) ) {
        callback = data;
        data = undefined;
      }
      this.apiRequest({
        method: 'get',
        url: this.apiUrl(url),
        params: data
      }, callback);
    },

    apiPost(url, data, callback) {
      // Shift arguments if data argument was omitted
      if ( _.isFunction(data) ) {
        callback = data;
        data = undefined;
      }
      this.apiRequest({
        method: 'post',
        url: this.apiUrl(url),
        data: data
      }, callback);
    },

    apiRequest(config, callback) {
      this.httpLoading  = true;
      this.httpError    = null;
      this.$http(config).then(r => {
        if ( _.isFunction(callback) ) {
          callback(r.data);
        }
        this.httpLoading = false;
      }).catch(err => {
        this.httpError = err.response;
        this.httpLoading = false;
      })
    },

    apiUrl(url) {
      let keys = url.match(/:\w+/g);
      // Replace URl parameters
      _.each(keys, key => {
        let k = key.replace(/\W/g, '');
        url = url.replace(key, this[k])
      })
      return this.PushType.apiBasePath + url;
    },

    loadData() {},
    resetData() {},
  },

  components: {
    TopBar,
    Debug
  }
}