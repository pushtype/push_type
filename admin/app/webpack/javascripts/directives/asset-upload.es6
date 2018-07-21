import Vue from 'vue';
import $ from 'jquery';

export default Vue.directive('asset-upload', {
  params: ['fallback-id', 'maxfiles'],
  bind: function() {
    let self = this,
        $el = $(self.el);

    if ( window.FileReader && Modernizr.draganddrop ) {
      if (self.params.fallbackId) {
        self.vm.hideFileField = true;
      }
      $el.filedrop({
        fallback_id:  self.params.fallbackId,
        url:          `${ PushType.Routes.adminPath }/media/upload`,
        paramname:    'asset[file]',
        maxfiles:     ( self.params.maxfiles || 1 ),
        maxfilesize:  35,
        dragOver:     function() { $(this).addClass('hover') },
        dragLeave:    function() { $(this).removeClass('hover') },
        drop:         function() { $(this).removeClass('hover') },
        uploadFinished: function(i, file, response, time) {
          self.vm.afterUpload(response.asset);
        },
        data: {
          authenticity_token: $('meta[name=csrf-token]').attr('content')
        }
      })
    } else {
      $el.hide()
    }
  }
})
