require "rails_helper"

feature "The user can manipulate rates", %q{
  As an authenticated user can create courses
  As an authenticated user can edit courses
  As an authenticated user can delete courses
} do

  given!(:roles) { create_list(:role, 1, name: 'mentor') }
  given!(:other_roles) { create_list(:role, 1, name: 'mentor') }
  given!(:user) { create(:user, roles: roles) }
  given!(:other_user) { create(:user, roles: other_roles) }
  given!(:profile) { create(:profile, user: user) }
  given!(:other_profile) { create(:profile, user: other_user) }

  describe "Authenticated user" do
    background do
      sign_in(user)

      click_on "My courses"
    end

    scenario "create a course" do
      # save_and_open_page
      click_on "New RecordedCourse"

      fill_in "Name", with: "New course"
      fill_in "Number hours video", with: 2
      click_on "Create"

      expect(page).to have_content "Recorded course was successfully created."
      expect(page).to have_content "New course"
    end

    scenario "create a course with errors" do
      click_on "New RecordedCourse"
      click_on "Create"

      expect(page).to have_content "can't be blank"
      expect(page).to have_content "can't be blank"
    end

    scenario "create a course with attached file" do
      click_on "New RecordedCourse"

      fill_in "Name", with: "New course"
      attach_file "Image", "#{Rails.root}/spec/fixtures/images/my_file.jpg"
      fill_in "Number hours video", with: 2
      click_on "Create"
      expect(page.find("img")["src"]).to have_content "my_file.jpg"
      expect(page).to have_content "Recorded course was successfully created."
      expect(page).to have_content "New RecordedCourse"
    end
  end

  describe "Authenticated user edit course" do
    given!(:course) { create :course, name: "First course", type: "RecordedCourse", user: user }

    background do
      sign_in(user)
      click_on "My courses"
      click_on "Edit"
    end

    scenario "edits his course" do
      fill_in "Name", with: "New course"
      fill_in "Number hours video", with: 2
      click_on "Update Recorded course"
# save_and_open_page
      expect(page).to_not have_content "First course"
      expect(page).to have_content "New RecordedCourse"
      expect(page).to have_content "Recorded course was successfully updated."
    end

    scenario "edits his coursse with errors" do
      fill_in "Name", with: ""
      fill_in "Number hours video", with: 2
      click_on "Update Recorded course"

      expect(page).to have_content "can't be blank"
    end

    scenario "edits a course with attached file" do
      attach_file "Image", "#{Rails.root}/spec/fixtures/images/my_file.jpg"
      fill_in "Number hours video", with: 2
      click_on "Update Recorded course"

      expect(page).to have_content "Recorded course was successfully updated."
      expect(page).to have_content "First course"
      expect(page.find("img")["src"]).to have_content "my_file.jpg"
    end
  end

  describe "Authenticated user" do
    given!(:course) { create :course, type: "RecordedCourse", user: user }

    scenario "can delete his question" do
      sign_in(user)
      click_on "My courses"
      expect(page).to have_content course.name
      click_on "Destroy"

      expect(page).to have_content "Recorded course was successfully destroyed."
      expect(current_path).to eq dashboard_courses_path
      expect(page).to have_no_content course.name
    end
  end

  describe "Authenticated other user" do
    given!(:course) { create :course, type: "RecordedCourse", user: user }
    given!(:other_course) { create :course, type: "RecordedCourse", user: other_user }

    scenario "can't edit and delete not your course" do
      sign_in(user)

      click_on "My courses"
      expect(page).to have_no_content other_course.name
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
