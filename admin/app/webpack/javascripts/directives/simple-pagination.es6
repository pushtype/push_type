import Vue from 'vue';
import $ from 'jquery';

export default Vue.directive('simple-pagination', function(meta) {
  let self = this;
  if (meta) {
    $(this.el).pagination({
      pages:          meta.total_pages,
      currentPage:    meta.current_page,
      prevText:       '&lsaquo; Prev',
      nextText:       'Next &rsaquo;',
      hrefTextPrefix: '#/media/page-',
      
      onPageClick: function(page, e) {
        e.preventDefault();
        self.vm.loadAssets(page);
      }
    })
       
  }
})
