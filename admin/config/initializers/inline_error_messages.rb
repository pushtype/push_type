ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag =~ /\<label/
    %(<div class="error">#{ html_tag }</div>)
  else
    %(<div class="error">#{ html_tag }<small class="error">#{ Array(instance.error_message).join(', ') }</small></div>)
  end.html_safe
end