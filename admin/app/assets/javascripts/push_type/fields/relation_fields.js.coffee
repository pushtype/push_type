# jQuery init
$(document).on 'ready page:load', ->

  $('select', '.relation, .node, .taxonomy').selectize
    plugins:      ['remove_button']
    hideSelected: false
    onInitialize: ->
      sel     = this
      options = sel.$input.data('options')
      items   = sel.$input.data('items')
      $.each options, -> sel.addOption this
      if $.isArray items
        $.each items, -> sel.addItem this
      else
        sel.addItem items
    render: 
      option: (item, esc) ->
        pre = if item.depth > 0 then '- '.repeat(item.depth) else ''
        """<div class="option">#{ pre }#{ esc item.text }</div>"""
