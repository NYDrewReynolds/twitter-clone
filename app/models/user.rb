class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    if user = find_by(uid: auth_info.extra.raw_info.user_id)
      user
    else
      create({name: auth_info.extra.raw_info.name,
              screen_name: auth_info.extra.raw_info.screen_name,
              uid: auth_info.extra.raw_info.user_id,
              oauth_token: auth_info.credentials.token,
              oauth_token_secret: auth_info.credentials.secret
             })
    end
  end

  def twitter_client
    user = User.find(self.id)
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["CONSUMER_KEY"]
      config.consumer_secret = ENV["CONSUMER_SECRET"]
      config.access_token = user.oauth_token
      config.access_token_secret = user.oauth_token_secret
    end
  end

  def twitter_user_profile
    @profile ||= twitter_client.user
  end

  def twitter_timeline
    twitter_client.home_timeline
  end

  def profile_image
    twitter_user_profile.profile_image_url
  end

  def banner_image
    twitter_user_profile.profile_banner_url
  end

  def followers_count
    twitter_user_profile.followers_count
  end

  def tweets_count
    twitter_user_profile.tweets_count
  end

  def friends_count
    twitter_user_profile.friends_count
  end
end
