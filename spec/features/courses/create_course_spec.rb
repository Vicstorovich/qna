feature "User can create course", %q{
  As an authenticated user
  I would like to be able to create courses
} do
  given(:user) { create(:user) }

  describe "Authenticated user" do
    background do
      sign_in(user)
      click_on "New course"
    end

    scenario "create a course" do
      fill_in "course_name", with: "New course"
      click_on "Save"

      expect(page).to have_content "Your course successfully created."
      expect(page).to have_content "New course"
    end

    scenario "create a course with errors" do
      click_on "Save"

      expect(page).to have_content "can't be blank"
    end

    scenario "create a course with attached file" do
      fill_in "course_name", with: "New course"
      attach_file "course_image", "#{Rails.root}/spec/support/assets/my_file.jpg"
      click_on "Save"

      expect(page.find("img")["src"]).to have_content "my_file.jpg"
      expect(page).to have_content "Your course successfully created."
      expect(page).to have_content "New course"
    end
  end
end
