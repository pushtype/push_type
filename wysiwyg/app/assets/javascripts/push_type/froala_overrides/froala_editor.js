/**
 * Override so the popup is never too bar below bottom of editor element
 */
$.Editable.prototype.showByCoordinates = function (x, y) {
  x = x - 22;
  y = y + 8;

  var $container = this.$document.find(this.options.scrollableContainer);

  if (this.options.scrollableContainer != 'body') {
    x = x - $container.offset().left;
    y = y - $container.offset().top;

    if (!this.iPad()) {
      x = x + $container.scrollLeft();
      y = y + $container.scrollTop();
    }
  }

  if (y > this.$box.offset().top + this.$box.outerHeight()) {
    y = this.$box.offset().top + this.$box.outerHeight();

    if (this.options.inlineMode) y = y + 10;
  }

  var editor_width = Math.max(this.$popup_editor.outerWidth(), 250);

  if (x + editor_width >= $container.outerWidth() - 50 && (x + 44) - editor_width > 0) {
    this.$popup_editor.addClass('right-side');
    x = $container.outerWidth() - (x + 44);

    if ($container.css('position') == 'static') {
      x = x + parseFloat($container.css('margin-left'), 10) + parseFloat($container.css('margin-right'), 10)
    }

    this.$popup_editor.css('top', y);
    this.$popup_editor.css('right', x);
    this.$popup_editor.css('left', 'auto');
  } else if (x + editor_width < $container.outerWidth() - 50) {
    this.$popup_editor.removeClass('right-side');
    this.$popup_editor.css('top', y);
    this.$popup_editor.css('left', x);
    this.$popup_editor.css('right', 'auto');
  } else {
    this.$popup_editor.removeClass('right-side');
    this.$popup_editor.css('top', y);
    this.$popup_editor.css('left', Math.max(($container.outerWidth() - editor_width), 10) / 2);
    this.$popup_editor.css('right', 'auto');
  }

  this.$popup_editor.show();
};
