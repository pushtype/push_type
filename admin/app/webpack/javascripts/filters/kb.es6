import Vue from 'vue';
import numeral from 'numeral';

export default Vue.filter('kb', (value) => numeral(value).format('0 b'))
