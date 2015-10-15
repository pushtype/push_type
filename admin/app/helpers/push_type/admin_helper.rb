module PushType
  module AdminHelper

    def title(page_title)
      content_for :title, page_title.to_s
    end

    def ficon(kind, label = nil, opts = {})
      opts.merge! class: 'fi-' + kind.to_s.gsub(/_/, '-')
      el = content_tag :i, nil, opts
      [el, label].compact.join(' ').html_safe
    end

  end
end
