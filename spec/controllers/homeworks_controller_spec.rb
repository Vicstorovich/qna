require 'rails_helper'

RSpec.describe HomeworksController, type: :controller do
  let(:mentor_role) { create_list(:role, 1, name: 'mentor') }
  let(:user_role) { create_list(:role, 1, name: 'user') }
  let(:mentor) { create(:user, roles: mentor_role) }
  let(:student) { create(:user, roles: user_role) }


  describe "POST #create" do
    let!(:course) { create(:course, user: mentor) }
    let!(:lesson) { create(:lesson, course: course) }

    before { log_in(student) }

    context "with valid attributes" do
      let(:action) do
        post :create, params: { course_id: course.id, lesson_id: lesson.id,
                                homework: attributes_for(:homework) }
      end

      it "check connection with logged-in user" do
        action
        expect(assigns(:homework).user).to eq student
      end

      it "saves the new lesson" do
        expect { action }.to change(lesson.homeworks, :count).by(1)
      end
    end

    context "with invalid attributes" do
      let(:action) do
         post :create, params: { course_id: course.id, lesson_id: lesson.id,
                                homework: attributes_for(:homework, :invalid) }
      end

      it "does not save the new homework" do
        expect { action }.to_not change(Homework, :count)
      end
    end
  end
end
