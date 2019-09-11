require 'rails_helper'

RSpec.describe LessonsController, type: :controller do
  let(:mentor_role) { create_list(:role, 1, name: 'mentor') }
  let(:user_role) { create_list(:role, 1, name: 'user') }
  let(:mentor) { create(:user, roles: mentor_role) }
  let(:student) { create(:user, roles: user_role) }

  describe '#index' do
    before { log_in(student) }

    let!(:course) { create(:course, user: mentor) }
    let!(:lessons) { create_list(:lesson, 3, course: course) }

    before  { student.participated_courses.push(course) }
    before { get :index, params: {course_id: course.id} }

      it 'should return paginated collection' do
        expect(response).to render_template(:index)
        expect(assigns(:lessons)).to match_array(lessons)
      end
  end

  describe "GET #show" do
    before { log_in(student) }

    let!(:course) { create(:course, user: mentor) }
    let!(:lesson) { create(:lesson, course: course) }

    before  { student.participated_courses.push(course) }
    before { get :show, params: {course_id: course, id: lesson} }

    it "assigns request lesson to @lesson" do
      expect(assigns(:lesson)).to eq lesson
    end

    it "renders show view" do
      expect(response).to render_template :show
    end
  end
end
