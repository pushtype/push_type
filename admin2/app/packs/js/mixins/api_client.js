import _ from 'lodash'

export default {
  data() {
    return {
      apiLoading: false,
      apiError:   null
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
      this.apiLoading = true;
      this.apiError   = null;
      this.$http(config).then(r => {
        if ( _.isFunction(callback) ) {
          callback(r.data);
        }
        this.apiLoading = false;
      }).catch(err => {
        this.apiError = err.response;
        this.apiLoading = false;
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
    }
  }
}