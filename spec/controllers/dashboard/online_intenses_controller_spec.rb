require 'rails_helper'

RSpec.describe Dashboard::OnlineIntensesController, type: :controller do
  let(:mentor_role) { create_list(:role, 1, name: 'mentor') }
  let(:user_role) { create_list(:role, 1, name: 'user') }
  let(:mentor) { create(:user, roles: mentor_role) }
  let(:student) { create(:user, roles: user_role) }

  before { log_in(mentor) }

  describe 'GET #new' do
    before { get :new, params: { type: 'OnlineIntense' } }

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:action) do
        post :create,
             params: { online_intense: attributes_for(:online_intense), type: 'OnlineIntense' }
      end

      it 'saves a new course in the database' do
        expect { action }.to change(Course, :count).by(1)

        action
        expect(response).to redirect_to dashboard_courses_path
      end
    end

    context 'with invalid attributes' do
      let(:action) do
        post :create,
             params: { online_intense: attributes_for(:online_intense, name: nil), type: 'OnlineIntense' }
      end

      it 'does not save the course' do
        expect { action }.to_not change(Course, :count)

        action
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: :course, type: 'OnlineIntense' } }

    it 'renders edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let(:course) { create(:online_intense, user: mentor) }

    context 'with valid attributes' do
      it 'assigns the requested course to @course' do
        patch :update, params: { id: course, online_intense: attributes_for(:online_intense), type: 'OnlineIntense' }
        expect(assigns(:online_intense)).to eq course
      end

      it 'changes course attributes' do
        expect(course.name).to eq 'MyCourse'
        patch :update, params: { id: course, online_intense: { name: 'new name' }, type: 'OnlineIntense' }
        course.reload

        expect(course.name).to eq 'new name'
      end

      it 'redirects to updated course' do
        patch :update, params: { id: course, online_intense: attributes_for(:online_intense), type: 'OnlineIntense' }

        expect(response).to redirect_to dashboard_courses_path
      end
    end

    context 'with invalid attributes' do
      before do
        patch :update,
              params: { id: course, online_intense: attributes_for(:online_intense, name: nil), type: 'OnlineIntense' }
      end

      it 'does not change course' do
        expect(course.name).to eq 'MyCourse'
        course.reload

        expect(course.name).to eq 'MyCourse'
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:course) { create(:online_intense, user: mentor) }
    let(:delete_action) { delete :destroy, params: { id: course, type: 'OnlineIntense' } }

    context 'if question belongs to the user' do
      it 'deletes course' do
        expect { delete_action }.to change(Course, :count).by(0)

        delete_action
        expect(response).to redirect_to dashboard_courses_path
      end
    end
  end
end
