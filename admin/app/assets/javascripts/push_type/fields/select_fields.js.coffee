opts =
  select:
    plugins:      ['remove_button']
    hideSelected: false

  tag_list:
    plugins:  ['remove_button', 'drag_drop']
    create:   true
    persist:  false

  relation:
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


@app.directive 'selectize', ->
  ($scope, $el, $attrs) ->
    switch $attrs['selectize']
      when 'select'                       then $($el).selectize opts.select
      when 'tag_list'                     then $($el).selectize opts.tag_list
      when 'relation', 'node', 'taxonomy' then $($el).selectize opts.relation
