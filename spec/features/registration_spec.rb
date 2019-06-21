require "rails_helper"

feature "Logged in user can sign out", %q{
  In order to finish work
  Logged in user can sign out
} do
  let!(:user) { create :user, email: "valid@test.com", password: "valid_password" }

  background { visit root_path; click_on "Sign up" }

  scenario "A new user can log in and log out" do
    fill_in "user_email", with: "another_valid@test.com"
    fill_in "user_password", with: "another_valid_password"
    click_on "Regstration"

    expect(current_path).to eq courses_path
    expect(page).to have_content "Signed in successfully."
    click_on "Log out"

    expect(current_path).to eq root_path
    expect(page).to have_content "Signed out successfully."
  end

  scenario "An existing user cannot register" do
    fill_in "user_email", with: "valid@test.com"
    fill_in "user_password", with: "valid_password"
    click_on "Regstration"

    expect(current_path).to eq registrations_path
    expect(page).to have_content "You are already registered!"
  end
end
