require "rails_helper"

RSpec.describe Dashboard::RecordedCoursesController, type: :controller do
  let(:mentor_role) { create_list(:role, 1, name: 'mentor') }
  let(:user_role) { create_list(:role, 1, name: 'user') }
  let(:mentor) { create(:user, roles: mentor_role) }
  let(:student) { create(:user, roles: user_role) }

  before { log_in(mentor) }


  describe "GET #new" do
    before { get :new, params: { type: 'RecordedCourse' } }

    it "renders new view" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:action) do
        post :create,
        params: { recorded_course: attributes_for(:recorded_course), type: 'RecordedCourse' }
      end

      it "saves a new course in the database" do
        expect { action }.to change(Course, :count).by(1)

        action
        expect(response).to redirect_to dashboard_courses_path
      end
    end

    context "with invalid attributes" do
      let(:action) do
        post :create,
        params: { recorded_course: attributes_for(:recorded_course, name: nil), type: 'RecordedCourse' }
      end

      it "does not save the course" do
        expect { action }.to_not change(Course, :count)

        action
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    before { get :edit, params: { id: :course , type: 'RecordedCourse'} }

    it "renders edit view" do
      expect(response).to render_template :edit
    end
  end

  describe "PATCH #update" do
    let(:course) { create(:recorded_course, user: mentor) }

    context "with valid attributes" do

      it "assigns the requested course to @course" do
        patch :update, params: { id: course, recorded_course: attributes_for(:recorded_course), type: 'RecordedCourse' }
        expect(assigns(:recorded_course)).to eq course
      end

      it "changes course attributes" do
        expect(course.name).to eq "MyCourse"
        patch :update, params: { id: course, recorded_course: { name: "new name" }, type: 'RecordedCourse' }
        course.reload

        expect(course.name).to eq "new name"
      end

      it "redirects to updated course" do
        patch :update, params: { id: course, recorded_course: attributes_for(:recorded_course), type: 'RecordedCourse' }

        expect(response).to redirect_to dashboard_courses_path
      end
    end

    context "with invalid attributes" do
      before do
       patch :update,
       params: { id: course, recorded_course: attributes_for(:recorded_course, name: nil), type: 'RecordedCourse' }
      end

      it "does not change course" do
        expect(course.name).to eq "MyCourse"
        course.reload

        expect(course.name).to eq "MyCourse"
      end
    end
  end

  describe "DELETE #destroy" do
    let(:course) { create(:recorded_course, user: mentor) }
    let(:delete_action) { delete :destroy, params: { id: course, type: 'RecordedCourse' } }

    context "if question belongs to the user" do
      it "deletes course" do
        expect { delete_action }.to change(Course, :count).by(0)

        delete_action
        expect(response).to redirect_to dashboard_courses_path
      end
    end
  end
end
