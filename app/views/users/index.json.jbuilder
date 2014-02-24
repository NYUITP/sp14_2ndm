json.array!(@users) do |user|
  json.extract! user, :firstName, :lastName, :email, :userName
  json.url user_url(user, format: :json)
end