# Examples using Rails’ link_to helper
#
# Basic usage:
#   = link_to 'Delete', foo_path(foo), method: :delete, data: { confirm: true }
#
# Customization of individual links/buttons via JSON in data-confirm:
#   = link_to 'Delete', foo_path(foo), method: :delete, data: {
#       confirm: {
#         title: 'You might want to think twice about this!',
#         body: 'If you click “Simon Says Delete” there will be no takebacks!',
#         ok: 'Simon Says Delete'
#       }
#     }
#
# Fall back to window.confirm() when confirm is a plain string:
#   = link_to 'Delete', foo_path(foo), method: :delete, confirm: 'Are you sure?'

$ = this.jQuery

$.fn.extend
  confirmWithReveal: (options = {}) ->

    defaults =
      modal_class: 'medium'
      title: 'Are you sure?'
      title_class: ''
      body: 'This action cannot be undone.'
      body_class: ''
      password: false
      prompt: 'Type <strong>%s</strong> to continue:'
      footer_class: ''
      ok: 'Confirm'
      ok_class: 'button alert'
      cancel: 'Cancel'
      cancel_class: 'button secondary'

    settings = $.extend {}, defaults, options

    do_confirm = ($el) ->

      el_options = $el.data('confirm')

      # The confirmation is actually triggered again when hitting "OK"
      # (or whatever) in the modal (since we clone the original link in),
      # but since we strip off the 'confirm' data attribute, we can tell
      # whether this is the first confirmation or a subsequent one.
      return true if !el_options

      if (typeof el_options == 'string') and (el_options.length > 0)
        return ($.rails?.confirm || window.confirm).call(window, el_options)

      option = (name) ->
        el_options[name] || settings[name]

      # TODO: allow caller to pass in a template (DOM element to clone?)
      modal = $("""
        <div data-reveal class='reveal-modal #{option 'modal_class'}'>
          <h2 data-confirm-title class='#{option 'title_class'}'></h2>
          <p data-confirm-body class='#{option 'body_class'}'></p>
          <div data-confirm-footer class='#{option 'footer_class'}'>
            <a data-confirm-cancel class='#{option 'cancel_class'}'></a>
          </div>
        </div>
        """)

      confirm_button = if $el.is('a') then $el.clone() else $('<a/>')
      confirm_button
        .removeAttr('data-confirm')
        .attr('class', option 'ok_class')
        .html(option 'ok')
        .on 'click', (e) ->
          return false if $(this).prop('disabled')
          # TODO: Handlers of this event cannot stop the confirmation from
          # going through (e.g. chaining additional validation). Fix TBD.
          $el.trigger('confirm.reveal', e)
          if $el.is('form, :input')
            $el
              .closest('form')
              .removeAttr('data-confirm')
              .submit()

      modal
        .find('[data-confirm-title]')
        .html(option 'title')
      modal
        .find('[data-confirm-body]')
        .html(option 'body')
      modal
        .find('[data-confirm-cancel]')
        .html(option 'cancel')
        .on 'click', (e) ->
          modal.foundation('reveal', 'close')
          $el.trigger('cancel.reveal', e)
      modal
        .find('[data-confirm-footer]')
        .append(confirm_button)

      if (password = option 'password')
        confirm_label =
          (option 'prompt')
            .replace '%s', password
        confirm_html = """
          <label>
            #{confirm_label}
            <input data-confirm-password type='text'/>
          </label>
          """
        modal
          .find('[data-confirm-body]')
          .after($(confirm_html))
        modal
          .find('[data-confirm-password]')
          .on 'keyup', (e) ->
            disabled = $(this).val() != password
            confirm_button
              .toggleClass('disabled', disabled)
              .prop('disabled', disabled)
          .trigger('keyup')

      modal
        .appendTo($('body'))
        .foundation()
        .foundation('reveal', 'open')
        .on 'closed.fndtn.reveal', (e) ->
          modal.remove()

      return false

    if $.rails

      # We do NOT do the event binding if $.rails exists, because jquery_ujs
      # has already done it for us

      $.rails.allowAction = (link) -> do_confirm $(link)
      return $(this)

    else

      handler = (e) ->
        unless (do_confirm $(this))
          e.preventDefault()
          e.stopImmediatePropagation()

      return @each () ->
        $el = $(this)
        $el.on 'click', 'a[data-confirm], :input[data-confirm]', handler
        $el.on 'submit', 'form[data-confirm]', handler
        $el