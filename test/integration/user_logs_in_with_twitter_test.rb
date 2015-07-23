require "test_helper"
class UserLogsInWithTwitterTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = TwitterClone::Application
    stub_omniauth
  end

  test "logging in" do
    VCR.use_cassette("user-timeline") do
      visit "/"
      assert_equal 200, page.status_code
      click_link "Login with Twitter"
      assert_equal "/feed", current_path
      assert page.has_content?("Drew Reynolds")
      assert page.has_link?("Logout")
      assert page.has_css?(".tweet")
    end
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
                                                                     provider: 'twitter',
                                                                     extra: {
                                                                         raw_info: {
                                                                             user_id: "1",
                                                                             name: "Drew Reynolds",
                                                                             screen_name: "nydrewreynolds",
                                                                         }
                                                                     },
                                                                     credentials: {
                                                                         token: ENV["SAMPLE_OAUTH_TOKEN"],
                                                                         secret: ENV["SAMPLE_OAUTH_TOKEN_SECRET"]
                                                                     }
                                                                 })
  end
end
