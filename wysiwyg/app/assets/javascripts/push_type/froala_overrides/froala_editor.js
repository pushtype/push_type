/**
 * Override so the popup is never too bar below bottom of editor element
 */
$.Editable.prototype.showByCoordinates = function (x, y) {
  
  var editor_width = Math.max(this.$popup_editor.width(), 250),
      bottom        = this.$element.offset().top + this.$element.outerHeight();

  y = Math.min(y, bottom);

  x = x - 20;
  y = y + 15;


  if (x + editor_width >= $(window).width() - 50 && (x + 40) - editor_width > 0) {
    this.$popup_editor.addClass('right-side');
    x = $(window).width() - (x + 40);
    this.$popup_editor.css('top', y);
    this.$popup_editor.css('right', x);
    this.$popup_editor.css('left', 'auto');
  } else if (x + editor_width < $(window).width() - 50) {
    this.$popup_editor.removeClass('right-side');
    this.$popup_editor.css('top', y);
    this.$popup_editor.css('left', x);
    this.$popup_editor.css('right', 'auto');
  } else {
    this.$popup_editor.removeClass('right-side');
    this.$popup_editor.css('top', y);
    this.$popup_editor.css('left', Math.max(($(window).width() - editor_width), 10) / 2);
    this.$popup_editor.css('right', 'auto');
  }

  this.$popup_editor.show();
};