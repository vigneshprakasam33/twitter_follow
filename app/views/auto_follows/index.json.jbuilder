json.array!(@auto_follows) do |auto_follow|
  json.extract! auto_follow, :id, :account_id, :follower_id, :followed, :follow_back
  json.url auto_follow_url(auto_follow, format: :json)
end
