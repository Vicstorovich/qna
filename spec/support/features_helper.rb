module FeaturesHelper
  def sign_in(user = create(:user))
    visit root_path
    click_on "Log in"
    fill_in "email", with: user.email
    fill_in "password", with: "12345678"
    click_on "Login"
  end
end
