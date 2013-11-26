require "instagram"
  Instagram.configure do |config|
  config.client_id = ENV['CLIENT_ID']
  config.access_token = ENV['ACCESS_TOKEN']
end

# curl -F 'client_id=1fc31d596d9e4404b2c11b5503a461a7' -F 'client_secret=e6b74d78a7b84c8face69e19c5ca7ede' -F 'grant_type=authorization_code' -F 'redirect_uri=http://localhost:3000' -F 'code=35c2a2c50c124625a91256bf99797f1a' https://api.instagram.com/oauth/access_token
