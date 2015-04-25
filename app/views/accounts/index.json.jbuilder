json.array!(@accounts) do |account|
  json.extract! account, :id, :uid, :name, :pass
  json.url account_url(account, format: :json)
end
