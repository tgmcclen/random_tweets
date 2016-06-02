require 'sinatra'
require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
  config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
  config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
  config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
end

get '/tag/:tag' do
  client.search("##{params['tag']}", result_type: "recent").take(1).collect do |tweet|
    "#{tweet.user.screen_name}: #{tweet.text}"
  end
end