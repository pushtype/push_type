/**
 * Override to add file upload UI
 */
$.Editable.prototype.fileUploadHTML = function () {
  var html = '<div class="froala-popup froala-file-popup" style="display: none;"><h4><span data-text="true">Upload file</span><i title="Cancel" class="fa fa-times" id="f-file-close-' + this._id + '"></i></h4>';

  html += '<div id="f-file-list-' + this._id + '">';

  html += '<div class="f-popup-line drop-upload">';
  html += '<div class="f-upload" id="f-file-upload-div-' + this._id + '"><strong data-text="true">Drop File</strong><br>(<span data-text="true">or click</span>)<form target="file-frame-' + this._id + '" enctype="multipart/form-data" encoding="multipart/form-data" action="' + this.options.fileUploadURL + '" method="post" id="f-file-form-' + this._id + '"><input id="f-file-upload-' + this._id + '" type="file" name="' + this.options.fileUploadParam + '" accept="/*"></form></div>';

  if (this.browser.msie && $.Editable.getIEversion() <= 9) {
    html += '<iframe id="file-frame-' + this._id + '" name="file-frame-' + this._id + '" src="javascript:false;" style="width:0; height:0; border:0px solid #FFF; position: fixed; z-index: -1;" data-loaded="true"></iframe>';
  }

  html += '</div>';

  // PT BEGIN
  if (this.options.fileLink) {
    html += '<div class="f-popup-line"><label><span data-text="true">Enter URL</span>: </label><input id="f-file-url-' + this._id + '" type="text" placeholder="http://example.com"><button class="f-browse fr-p-bttn" id="f-browser-' + this._id + '"><i class="fa fa-search"></i></button><button data-text="true" class="f-ok fr-p-bttn" id="f-file-ok-' + this._id + '">OK</button></div>';
  }
  // PT END

  html += '</div>';
  html += '<p class="f-progress" id="f-file-progress-' + this._id + '"><span></span></p>';
  html += '</div>';

  return html;
}


/**
 * Override to integrate with media manager
 */
$.Editable.prototype.buildFileUpload = function () {
  // Add file wrapper to editor.
  this.$file_wrapper = $(this.fileUploadHTML());
  this.$popup_editor.append(this.$file_wrapper);

  this.buildFileDrag();

  var that = this;

  // Stop event propagation in file.
  this.$file_wrapper.on('mouseup touchend', $.proxy(function (e) {
    if (!this.isResizing()) {
      e.stopPropagation();
    }
  }, this));

  this.addListener('hidePopups', $.proxy(function () {
    this.hideFileWrapper();
  }), this);

  // Init progress bar.
  this.$file_progress_bar = this.$file_wrapper.find('p#f-file-progress-' + this._id);

  // Build upload frame.
  if (this.browser.msie && $.Editable.getIEversion() <= 9) {
    var iFrame = this.$file_wrapper.find('iframe').get(0);

    if (iFrame.attachEvent) {
      iFrame.attachEvent('onload', function () { that.iFrameLoad() });
    } else {
      iFrame.onload  = function () { that.iFrameLoad() };
    }
  }

  // File was picked.
  this.$file_wrapper.on('change', 'input[type="file"]', function () {
    // Files were picked.
    if (this.files !== undefined) {
      that.uploadFile(this.files);
    }

    // IE 9 upload.
    else {
      var $form = $(this).parents('form');
      $form.find('input[type="hidden"]').remove();
      var key;
      for (key in that.options.fileUploadParams) {
        $form.prepend('<input type="hidden" name="' + key + '" value="' + that.options.fileUploadParams[key] + '" />');
      }

      that.$file_wrapper.find('#f-file-list-' + that._id).hide();
      that.$file_progress_bar.show();
      that.$file_progress_bar.find('span').css('width', '100%').text('Please wait!');
      that.showFileUpload();

      $form.submit();
    }

    // Chrome fix.
    $(this).val('');
  });

  // PT BEGIN
  // Create a list with all the items from the popup.
  this.$file_wrapper.on('click', '#f-file-ok-' + this._id, $.proxy(function () {
    var file = this.$file_wrapper.find('#f-file-url-' + this._id).val();
    if (file !== '') {
      this.writeFile(file, file);
    }
  }, this));
  // PT END

  // Wrap things in file wrapper.
  this.$file_wrapper.on(this.mouseup, '#f-file-close-' + this._id, $.proxy(function (e) {
    e.stopPropagation();
    e.preventDefault();

    this.$bttn_wrapper.show();
    this.hideFileWrapper();

    this.restoreSelection();
    this.focus();

    this.hide();
  }, this))

  // PT BEGIN
  this.$file_wrapper
    .on('click', '#f-browser-' + this._id, $.proxy(function () {
      this.showMediaManager('file');
    }, this))
    .on('click', '#f-browser-' + this._id + ' i', $.proxy(function () {
      this.showMediaManager('file');
    }, this));

  this.$file_wrapper.find('#f-browser-' + this._id).show();
  // PT END

  this.$file_wrapper.on('click', function (e) {
    e.stopPropagation();
  });

  this.$file_wrapper.on('click', '*', function (e) {
    e.stopPropagation();
  });
};

$.Editable.initializers.push($.Editable.prototype.buildFileUpload);