feature "User can edit course", %q{
  To fix errors
  As the author of the course
  I would like to be able to edit the course
} do
  given!(:user) { create(:user) }
  given!(:course) { create :course, name: "First course" }

  describe "Authenticated user" do
    background do
      sign_in(user)
      # save_and_open_page
      click_on "Edit"
    end

    scenario "edits his course" do
      fill_in "course_name", with: "New course"
      click_on "Save"

      expect(page).to_not have_content "First course"
      expect(page).to have_content "New course"
      expect(page.find("img")["src"]).to have_content "thumb_my_file.jpg"
      expect(page).to have_content "The course was updated successfully."
    end

    scenario "edits his coursse with errors" do
      fill_in "course_name", with: " "
      click_on "Save"

      expect(page).to have_content "can't be blank"
    end

    scenario "edits a course with attached file" do
      fill_in "course_name", with: "New course"
      attach_file "course_image", "#{Rails.root}/spec/support/assets/my_file.jpg"
      click_on "Save"

      expect(page).to have_content "The course was updated successfully."
      expect(page).to have_no_content "First course"
      expect(page).to have_content "New course"
      expect(page.find("img")["src"]).to have_content "my_file.jpg"
    end
  end
end
