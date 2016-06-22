json.user do
  json.partial! 'user', user: @user

  @user.fields.each do |key, field|
    json.set! key, field.value
  end
end

if params[:action] == 'show'
  json.meta do
    json.fields @user.fields do |key, field|
      json.name field.name
      json.kind field.kind
    end
  end
end
