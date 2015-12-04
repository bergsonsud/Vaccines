json.array!(@users) do |user|
  json.extract! user, :id, :name, :cpf
  json.url user_url(user, format: :json)
end
