# @private
class Breadcrumbs
  module Render
    class Foundation < List
      def render_item(item, i, size)
        text, url, options = *item
        text = wrap_item(url, CGI.escapeHTML(text), options)
        tag :li, text, class: ('current' if i == size - 1)
      end
    end
  end
end