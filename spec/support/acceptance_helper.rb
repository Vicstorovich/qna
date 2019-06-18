module AcceptancesHelper
  def sign_in(user = create(:user))
    visit login_path
    fill_in "email", with: user.email
    fill_in "password", with: user.password
    click_on "Log in"
  end
end
