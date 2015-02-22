/**
 * Override to accept kind param which sets title of media manager
 */
  // PT BEGIN
$.Editable.prototype.showMediaManager = function (kind) {
  this.$image_modal.data('context', kind);
  this.$image_modal.find('h4 span').text('Manage '+ kind +'s');
  // PT END
  this.$image_modal.show();
  this.$overlay.show();
  this.loadImages();
  this.$document.find('body').css('overflow','hidden');
}


/**
 * Override to add pagination UI
 */
$.Editable.prototype.mediaModalHTML = function () {
  var html = '<div class="froala-modal"><div class="f-modal-wrapper"><h4><span data-text="true">Manage images</span><i title="Cancel" class="fa fa-times" id="f-modal-close-' + this._id + '"></i></h4>'

  html += '<img class="f-preloader" id="f-preloader-' + this._id + '" alt="Loading..." src="' + this.options.preloaderSrc + '" style="display: none;">';

  if (WYSIWYGModernizr.touch) {
    html += '<div class="f-image-list f-touch" id="f-image-list-' + this._id + '"></div>';
  } else {
    html += '<div class="f-image-list" id="f-image-list-' + this._id + '"></div>';
  }

  // PT BEGIN
  html += '<div class="pagination-centered" id="f-pagination-' + this._id + '"></div>';
  // PT END

  html += '</div></div>';

  return html;
}


/**
 * Override so media manage can be used for images and files
 */
$.Editable.prototype.buildMediaManager = function () {
  this.$image_modal = $(this.mediaModalHTML()).appendTo('body');
  this.$preloader = this.$image_modal.find('#f-preloader-' + this._id);
  this.$media_images = this.$image_modal.find('#f-image-list-' + this._id);
  this.$overlay = $('<div class="froala-overlay">').appendTo('body');

  // Stop event propagation on overlay.
  this.$overlay.on('mouseup', $.proxy(function (e) {
    if (!this.isResizing()) {
      e.stopPropagation();
    }
  }, this));


  // Stop event propagation in modal.
  this.$image_modal.on('mouseup', $.proxy(function (e) {
    if (!this.isResizing()) {
      e.stopPropagation();
    }
  }, this));

  // Close button.
  this.$image_modal.find('i#f-modal-close-' + this._id)
    .click($.proxy(function () {
      this.hideMediaManager();
    }, this));

  // Select image.
  this.$media_images.on(this.mouseup, 'img', $.proxy(function (e) {
    e.stopPropagation();
    var img = e.currentTarget;
    // PT BEGIN
    if ( $(img).data('kind') == 'image' ) {
      this.writeImage($(img).data('src'));
    } else {
      this.writeFile($(img).data('src'), $(img).data('title'));
    }
    // PT END
    this.hideMediaManager();
  }, this));

  // Delete image.
  this.$media_images.on(this.mouseup, '.f-delete-img', $.proxy(function (e) {
    e.stopPropagation();
    var img = $(e.currentTarget).prev();
    var message = 'Are you sure? Image will be deleted.';
    if ($.Editable.LANGS[this.options.language]) {
      message = $.Editable.LANGS[this.options.language].translation[message];
    }

    // Ask for confirmation.
    if (confirm(message)) {
      if (this.triggerEvent('beforeDeleteImage', [$(img)], false) !== false) {
        $(img).parent().addClass('f-img-deleting');
        this.deleteImage($(img));
      }
    }
  }, this));

  // Add button for media manager to image.
  if (this.options.mediaManager) {
    // PT BEGIN
    this.$image_wrapper
      .on('click', '#f-browser-' + this._id, $.proxy(function () {
        this.showMediaManager('image');
      }, this))
      .on('click', '#f-browser-' + this._id + ' i', $.proxy(function () {
        this.showMediaManager('image');
      }, this));
    // PT END

    this.$image_wrapper.find('#f-browser-' + this._id).show();
  }

  this.hideMediaManager();
};


/**
 * Initilizes pagination control (new code)
 */
$.Editable.prototype.initPagination = function(data) {
  var mm = this;
  this.$image_modal.find('#f-pagination-' + this._id).pagination({
    pages: data.meta.total_pages,
    currentPage: data.meta.current_page,
    hrefTextPrefix: '#/media/page-',
    onPageClick: function(page, e) {
      e.preventDefault();
      mm.loadImages(page);
    }
  });
}


/**
 * Override so loads images and files
 */
  // PT BEGIN
$.Editable.prototype.loadImages = function (page) {
  var isPaginated = (typeof page !== 'undefined');
  // PT END

  this.$preloader.show();
  this.$media_images.empty();

  // PT BEGIN
  if (this.$image_modal.data('context') == 'file') {
    ajax = {
      url: this.options.filesLoadURL,
      opts: this.options.filesLoadParams
    }
  } else {
    ajax = {
      url: this.options.imagesLoadURL,
      opts: this.options.imagesLoadParams
    }
  }
  if (isPaginated) {
    ajax.opts.page = page;
  }
  // PT END

  if (ajax.url) { // PT EDIT
    $.support.cors = true;
    $.getJSON(ajax.url, ajax.opts, $.proxy(function (data) { // PT EDIT
      // data
      this.triggerEvent('imagesLoaded', [data], false);
      // PT BEGIN
      this.processLoadedImages(data.assets);
      if (!isPaginated && data.meta.total_pages > 1) {
        this.initPagination(data);
      }
      // PT END
      this.$preloader.hide();
    }, this))
      .fail($.proxy(function () {
        this.throwLoadImagesError(2);
      }, this));
  }
  else {
    this.throwLoadImagesError(3);
  }
};


/**
 * Override to replace delete button with title element
 */
$.Editable.prototype.loadImage = function (src, info) {
  var img = new Image();
  var $li = $('<div>').addClass('f-empty');
  img.onload = $.proxy(function () {
    var delete_msg = 'Delete';
    if ($.Editable.LANGS[this.options.language]) {
      delete_msg = $.Editable.LANGS[this.options.language].translation[delete_msg];
    }

    var $img = $('<img src="' + src + '"/>');
    for (var k in info) {
      $img.attr('data-' + k, info[k]);
    }

    // PT BEGIN
    $li.append($img).append('<span class="f-media-title">'+ info.title +'</span>');
    // PT END
    $li.removeClass('f-empty');
    this.$media_images.hide();
    this.$media_images.show();
    this.triggerEvent('imageLoaded', [src], false);
  }, this);

  img.onerror = $.proxy(function () {
    $li.remove();
    this.throwLoadImagesError(1);
  }, this)

  img.src = src;
  this.$media_images.append($li);
};