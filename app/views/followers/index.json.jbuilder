json.array!(@followers) do |follower|
  json.extract! follower, :id, :uid, :celebrity_id, :handle
  json.url follower_url(follower, format: :json)
end
