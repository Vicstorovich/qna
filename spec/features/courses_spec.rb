require "rails_helper"

feature "The user can manipulate rates", %q{
  As an authenticated user can create courses
  As an authenticated user can edit courses
  As an authenticated user can delete courses
} do
  given!(:user) { create(:user) }

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
<<<<<<< HEAD
      attach_file "course_image", "#{Rails.root}/spec/support/assets/my_file.jpg"
=======
      attach_file "course_image", "#{Rails.root}/spec/fixtures/images/my_file.jpg"
>>>>>>> 589507f2641b5fe7a088728c26c1b35c33141e22
      click_on "Save"

      expect(page.find("img")["src"]).to have_content "my_file.jpg"
      expect(page).to have_content "Your course successfully created."
      expect(page).to have_content "New course"
    end
  end

  describe "Authenticated user" do
    given!(:course) { create :course, name: "First course" }

    background do
      sign_in(user)
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
<<<<<<< HEAD
      attach_file "course_image", "#{Rails.root}/spec/support/assets/my_file.jpg"
=======
      attach_file "course_image", "#{Rails.root}/spec/fixtures/images/my_file.jpg"
>>>>>>> 589507f2641b5fe7a088728c26c1b35c33141e22
      click_on "Save"

      expect(page).to have_content "The course was updated successfully."
      expect(page).to have_no_content "First course"
      expect(page).to have_content "New course"
      expect(page.find("img")["src"]).to have_content "my_file.jpg"
    end
  end

  describe "Authenticated user" do
    given!(:course) { create :course }

    scenario "can delete his question" do
      sign_in(user)
      expect(page).to have_content course.name
      click_on "Delete"

      expect(page).to have_content "Course was successfully deleted"
      expect(current_path).to eq courses_path
      expect(page).to have_no_content course.name
    end
  end
end
