require "rails_helper"

feature "The user can manipulate rates", %q{
  As an authenticated user can create courses
  As an authenticated user can edit courses
  As an authenticated user can delete courses
} do
  given!(:user) { create(:user) }
  given!(:other_user) { create(:user) }

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
      attach_file "course_image", "#{Rails.root}/spec/fixtures/images/my_file.jpg"
      click_on "Save"

      expect(page.find("img")["src"]).to have_content "my_file.jpg"
      expect(page).to have_content "Your course successfully created."
      expect(page).to have_content "New course"
    end
  end

  describe "Authenticated user" do
    given!(:course) { create :course, name: "First course", user: user }

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
      attach_file "course_image", "#{Rails.root}/spec/fixtures/images/my_file.jpg"
      click_on "Save"

      expect(page).to have_content "The course was updated successfully."
      expect(page).to have_no_content "First course"
      expect(page).to have_content "New course"
      expect(page.find("img")["src"]).to have_content "my_file.jpg"
    end
  end

  describe "Authenticated user" do
    given!(:course) { create :course, user: user }

    scenario "can delete his question" do
      sign_in(user)
      expect(page).to have_content course.name
      click_on "Delete"

      expect(page).to have_content "Course was successfully deleted"
      expect(current_path).to eq dashboard_courses_path
      expect(page).to have_no_content course.name
    end
  end

  describe "Authenticated other user" do
    given!(:course) { create :course, user: user }
    given!(:other_course) { create :course, user: other_user }

    scenario "can't edit and delete not your course" do
      sign_in(other_user)

      expect(page).to have_no_content course.name
    end

    scenario "can only view all courses" do
      sign_in(other_user)
      click_on "All courses"

      expect(page).to have_content course.name
      expect(page).to have_content other_course.name
      expect(page).to have_no_link 'Edit'
      expect(page).to have_no_link 'Delete'
    end
  end
end
