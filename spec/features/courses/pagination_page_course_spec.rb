feature "Check the correct operation of the pagination pages", %q{
  Setting pagination pages
  Two objects courses page
} do
  given!(:user) { create(:user) }
  given!(:course1) { create :course, name: "first_course" }
  given!(:course2) { create :course, name: "second_course" }
  given!(:course3) { create :course, name: "third_course" }
  given!(:course4) { create :course, name: "fourth_course" }

  describe "Authenticated user" do
    scenario "looks all courses" do
      sign_in(user)
      expect(page).to have_selector "div.course-#{course1.id}", text: "first_course"
      expect(page).to have_selector "div.course-#{course2.id}", text: "second_course"
      expect(page).to have_no_selector "div.course-#{course3.id}", text: "third_course"
      expect(page).to have_no_selector "div.course-#{course4.id}", text: "fourth_course"
      click_on "Next"

      expect(page).to have_no_selector "div.course-#{course1.id}", text: "first_course"
      expect(page).to have_no_selector "div.course-#{course2.id}", text: "second_course"
      expect(page).to have_selector "div.course-#{course3.id}", text: "third_course"
      expect(page).to have_selector "div.course-#{course4.id}", text: "fourth_course"
      expect(page).to have_no_link('Next')
    end
  end
end
