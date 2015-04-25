json.array!(@celebrities) do |celebrity|
  json.extract! celebrity, :id, :uid, :handle, :category
  json.url celebrity_url(celebrity, format: :json)
end
