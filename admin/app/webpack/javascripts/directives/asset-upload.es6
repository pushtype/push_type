import Vue from 'vue';
import $ from 'jquery';

export default Vue.directive('asset-upload', {
  params: ['upload-path', 'fallback-id', 'maxfiles'],
  bind: function() {
    let self = this,
        $el = $(self.el);

    if ( window.FileReader && Modernizr.draganddrop ) {
      if (self.params.fallbackId) {
        self.vm.hideFileField = true;
      }
      $el.filedrop({
        fallback_id:  self.params.fallbackId,
        url:          self.params.uploadPath,
        paramname:    'asset[file]',
        maxfiles:     ( self.params.maxfiles || 1 ),
        dragOver:     function() { $(this).addClass('hover') },
        dragLeave:    function() { $(this).removeClass('hover') },
        drop:         function() { $(this).removeClass('hover') },
        uploadFinished: function(i, file, response, time) {
          self.vm.afterUpload(response.asset);
        }
      })
    } else {
      $el.hide()
    }
  }
})