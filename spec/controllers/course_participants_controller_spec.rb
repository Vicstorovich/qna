require 'rails_helper'

RSpec.describe CourseParticipantsController, type: :controller do
  let(:mentor_role) { create_list(:role, 1, name: 'mentor') }
  let(:user_role) { create_list(:role, 1, name: 'user') }
  let(:mentor) { create(:user, roles: mentor_role) }
  let(:student) { create(:user, roles: user_role) }

  describe '#index' do
    before { log_in(student) }

    let(:course) { create(:course, user: mentor) }

    # let(:action)  { student.participated_courses.push(course) }

    before { get :index, params: { course_id: course.id } }

    it 'should return collection of course participants' do
      expect(response).to render_template(:index)
      expect(assigns(:course).to_a).to match_array(course.course_users)
    end

    # it "should add course to participate" do
    #   expect { action }.to change(course.course_users, :count).by(1)
    # end
  end
end
