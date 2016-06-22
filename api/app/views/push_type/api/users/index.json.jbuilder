json.users @users do |user|
  json.partial! 'user', user: user
end

json.meta do
  json.partial! 'push_type/api/shared/pagination', collection: @users
end
