json.array!(@users) do |user|
  json.extract! user, :id, :fname, :lname, :company_id
  json.url user_url(user, format: :json)
end
