feature "User can sign in", %q{
  As an unauthenticated user
  I'd like to be able to sign in
} do
  let!(:user) { create :user, email: "valid@test.com", password: "valid_password" }

  background { visit root_path; click_on "Log in" }

  scenario "Registered user tries to sign in" do
    fill_in "email", with: "valid@test.com"
    fill_in "password", with: "valid_password"
    click_on "Login"

    expect(page).to have_content "Courses"
    expect(page).to have_link "Log out"
    expect(page).to have_content "Signed in successfully."
  end

  scenario "Unregistered user tries to sign in" do
    fill_in "email", with: "wrong@test.com"
    fill_in "password", with: "12345678"
    click_on "Login"

    expect(page).to_not have_link "Log out"
    expect(page).to have_link "Log in"
    expect(page).to have_content "Invalid Email or password."
  end
end
