require 'test_helper'

class TweetssControllerTest < ActionController::TestCase
  test "user can post a tweet" do
    user = User.create( uid: "1",
        name: "Drew Reynolds",
        screen_name: "nydrewreynolds",
        oauth_token: ENV["SAMPLE_OAUTH_TOKEN"],
        oauth_token_secret: ENV["SAMPLE_OAUTH_TOKEN_SECRET"]
    )
    session[:user_id] = user.id

    VCR.use_cassette("drew_tweets") do
      post :create, :tweet => "Tweeting from my twitter clone: https://drew-twitter-clone.herokuapp.com"
      assert_response :success
      assert_not_nil assigns(:tweets)
      assert_select "li.tweet"
    end
  end
end
