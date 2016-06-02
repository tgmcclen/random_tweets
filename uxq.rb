require 'sinatra'
require 'twitter'

class UxqTwitter
  @@client = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
    config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
    config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
  end

  @@tweets = {}

  def self.client
    @@client
  end

  def self.tweets
    @@tweets
  end
end

get '/tag/:tag' do
  tag = params['tag']
  refresh(tag) if UxqTwitter.tweets[tag] == nil
  t = UxqTwitter.tweets[tag].sample
  "<h1>#{t.user.screen_name}: #{t.text}</h1>"
end

def refresh(tag)
  UxqTwitter.tweets[tag] = UxqTwitter.client.search("##{tag}", result_type: "mixed", count: 15).to_a
end