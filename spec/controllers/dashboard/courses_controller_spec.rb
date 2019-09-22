require "rails_helper"

RSpec.describe Dashboard::CoursesController, type: :controller do
  let(:mentor_role) { create_list(:role, 1, name: 'mentor') }
  let(:user_role) { create_list(:role, 1, name: 'user') }
  let(:mentor) { create(:user, roles: mentor_role) }
  let(:student) { create(:user, roles: user_role) }

  before { log_in(mentor) }

  describe "GET #index" do
    let(:courses) { create_list(:course, 2, user: mentor) }

    before { get :index }

    it "fills the array of courses according to pagination" do
      expect(assigns(:courses)).to match_array(courses)

      expect(response).to render_template :index
    end
  end

  describe '#show' do
    let(:course) { create(:course, user: mentor) }
    let(:course_users) { course.course_users }

    before { get :show, params: { id: course } }

    it 'should return collection of course participants' do
      expect(response).to render_template(:show)
      expect(assigns(:course_users)).to eq course_users
    end
  end

  describe "DELETE #destroy" do
    let(:course) { create(:course, user: mentor) }
    let(:delete_action) { delete :destroy, params: { id: course } }

    context "if question belongs to the user" do
      it "deletes course" do
        expect { delete_action }.to change(Course, :count).by(0)
        expect(response).to redirect_to(dashboard_courses_path)
        expect(flash[:notice]).to eq 'Course was successfully destroyed.'
      end
    end
  end
end
