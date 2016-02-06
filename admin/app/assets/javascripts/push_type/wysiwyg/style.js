/*!
 * PushType Style plugin for froala_wysiwyg
 */

$.FroalaEditor.PLUGINS.ptStyle = function (editor) {
  var $current_image;

  // The start point for your plugin.
  function _init () { }

  // Display popup
  function showPopup() {
    $current_image = editor.image.get();
    var $popup = editor.popups.get('image.size');
    if (!$popup) $popup = _initPopup();

    editor.image.hideProgressBar();
    editor.popups.refresh('image.size');
    editor.popups.setContainer('image.size', $(editor.opts.scrollableContainer));
    var left = $current_image.offset().left + $current_image.width() / 2;
    var top = $current_image.offset().top + $current_image.height();

    editor.popups.show('image.size', left, top, $current_image.outerHeight());
  }

  // Initialize popup
  function _initPopup() {
    var buttons     = '<div class="fr-buttons">' + editor.button.buildList(editor.opts.imageSizeButtons) + '</div>';
    var size_layer  = '<div class="fr-image-size-layer fr-layer fr-active" id="fr-image-size-layer-' + editor.id + '"><div class="fr-image-group"><div class="fr-input-line">'+ _selectTag() +'</div><div class="fr-input-line pt-custom"><input type="text" name="custom" placeholder="' + editor.language.translate('Size') + '" tabIndex="1"></div></div><div class="fr-action-buttons"><button type="button" class="fr-command fr-submit" data-cmd="imageSetSize" tabIndex="2">' + editor.language.translate('Update') + '</button></div></div>';
    var $popup = editor.popups.create('image.size', {
      buttons: buttons,
      size_layer: size_layer
    });

    var $customRow = $popup.find('.pt-custom');
    $popup.find('select[name="style"]').on('change', function(){
      if ( $(this).val() === '_custom' ) {
        $customRow.show();
      } else {
        $customRow.hide();
      }
    });
    editor.popups.onRefresh('image.size', _refreshPopup);
    return $popup;
  }

  // Refresh popup
  function _refreshPopup () {
    if ($current_image) {
      var $popup  = editor.popups.get('image.size'),
          style   = _currentStyle();

      var $styleField   = $popup.find('select[name="style"]'),
          $customField  = $popup.find('input[name="custom"]');

      if ($.inArray(style, editor.opts.imageMediaStyles) !== -1) {
        $styleField.val(style);
        $customField.val('');
      } else {
        $styleField.val('_custom');
        $customField.val(style);
      }
      $styleField.trigger('change');
      $customField.trigger('change');
    }
  }

  // Return select tag HTML
  function _selectTag() {
    var html = '<select name="style" tabIndex="1">';
    html += _.map(editor.opts.imageMediaStyles, function(style) {
      var label = style.charAt(0).toUpperCase() + style.substring(1).replace(/_/, ' ');
      return '<option value="'+ style +'">'+ label +'</option>';
    }).join()
    html += '<option value="_custom">Custom</option>';
    html += '</select>';
    return html;
  }

  // Get current style
  function _currentStyle() {
    var image_src     = $current_image.attr('src'),
        mediaMatch    = image_src != 'undefined' ? image_src.match(/\?.*style=(\w+[%0-9a-z!]*)/i) : false;
    return mediaMatch ? decodeURIComponent(mediaMatch[1]) : 'original';
  }

  // Set style
  function setStyle (style) {
    if ($current_image) {
      var $popup        = editor.popups.get('image.size'),
          $styleField   = $popup.find('select[name="style"]'),
          $customField  = $popup.find('input[name="custom"]'),
          image_src;

      style = style || $styleField.val() === '_custom' ? $customField.val() : $styleField.val();
      image_src = $current_image.attr('src').split('?')[0] + '?style=' + encodeURIComponent(style);
      $current_image.attr('src', image_src);

      $popup.find('select, input').blur();

      setTimeout(function () {
        $current_image.trigger('click').trigger('touchend');
      }, 100);
    }
  }

  // Expose public methods.
  return {
    _init: _init,
    showPopup: showPopup,
    setStyle: setStyle
  }
}

// Overide built and and already defined functions
$.FroalaEditor.COMMANDS['imageSize'].callback = function() {
  this.ptStyle.showPopup();
}
$.FroalaEditor.COMMANDS['imageSetSize'].callback = function() {
  this.ptStyle.setStyle();
}
