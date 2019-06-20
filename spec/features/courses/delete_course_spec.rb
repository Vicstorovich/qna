feature "User can delete course", %q{
  As the user who created the course
  I want to delete it
} do
  given!(:user) { create(:user) }
  given!(:course) { create :course }

  scenario "Authenticated user can delete his question" do
    sign_in(user)

    expect(page).to have_content course.name
    click_on "Delete"

    expect(page).to have_content "Course was successfully deleted"
    expect(current_path).to eq courses_path
    expect(page).to have_no_content course.name
  end
end
