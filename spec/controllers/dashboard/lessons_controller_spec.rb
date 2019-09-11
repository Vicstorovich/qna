require "rails_helper"

RSpec.describe Dashboard::LessonsController, type: :controller do
  let(:mentor_role) { create_list(:role, 1, name: 'mentor') }
  let(:user_role) { create_list(:role, 1, name: 'user') }
  let(:mentor) { create(:user, roles: mentor_role) }
  let(:student) { create(:user, roles: user_role) }

  before { log_in(mentor) }

  describe "GET #index" do
    before { log_in(student) }

    let!(:course) { create(:course, user: mentor) }
    let!(:lessons) { create_list(:lesson, 3, course: course) }

    before { get :index, params: {course_id: course.id} }

    it 'should return paginated collection' do
      expect(response).to render_template(:index)
      expect(assigns(:lessons)).to match_array(lessons)
    end
  end

  describe '#show' do
    let(:course) { create(:course, user: mentor) }
    let(:lesson) { create(:lesson, course: course) }

    before { get :show, params: { course_id: course, id: lesson } }

    it 'should return collection of course participants' do
      expect(response).to render_template(:show)
      expect(assigns(:lesson)).to eq lesson
    end
  end

  describe "GET #new" do
    let(:course) { create(:course, user: mentor, type: 'RecordedCourse') }

    before { get :new, params: { course_id: course } }

    it "renders new view" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    let!(:course) { create(:course, user: mentor, type: 'RecordedCourse') }

    context "with valid attributes" do
      let(:action) do
        post :create,
        params: { course_id: course.id, lesson: attributes_for(:lesson) }
      end

      it "saves a new course in the database" do
        expect { action }.to change(Lesson, :count).by(1)

        action
        expect(response).to redirect_to dashboard_course_lessons_path
      end
    end

    context "with invalid attributes" do
      let(:action) do
        post :create,
        params: { course_id: course.id, lesson: attributes_for(:lesson, title: nil) }
      end

      it "does not save the course" do
        expect { action }.to_not change(Course, :count)

        action
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    let!(:course) { create(:course, user: mentor, type: 'RecordedCourse') }
    let(:lesson) { create(:lesson, course: course) }

    before { get :edit, params: { course_id: course , id: lesson} }

    it "renders edit view" do
      expect(response).to render_template :edit
    end
  end

  describe "PATCH #update" do
    let(:course) { create(:recorded_course, user: mentor, type: 'RecordedCourse') }
    let(:lesson) { create(:lesson, course: course, title: "Lesson9") }

    context "with valid attributes" do

      it "assigns the requested course to @course" do
        patch :update, params: { course_id: course, id: lesson, lesson: attributes_for(:lesson) }
        expect(assigns(:lesson)).to eq lesson
      end

      it "changes course attributes" do
        expect(lesson.title).to eq "Lesson9"
        patch :update, params: { course_id: course.id, id: lesson, lesson: { title: "new name" } }
        lesson.reload

        expect(lesson.title).to eq "new name"
      end

      it "redirects to updated course" do
        patch :update, params: { course_id: course, id: lesson, lesson: attributes_for(:lesson) }
        expect(response).to redirect_to dashboard_course_lessons_path
      end
    end

    context "with invalid attributes" do
      before do
        patch :update,
        params: { course_id: course.id, id: lesson, lesson: { title: nil } }
      end

      it "does not change course" do
        expect(lesson.title).to eq "Lesson9"
        course.reload

        expect(lesson.title).to eq "Lesson9"
      end
    end
  end

  describe "DELETE #destroy" do
    let(:course) { create(:recorded_course, user: mentor, type: 'RecordedCourse') }
    let(:lesson) { create(:lesson, course: course) }
    let(:delete_action) do
      delete :destroy, params: { course_id: course, id: lesson, lesson: attributes_for(:lesson) }
    end

    context "if question belongs to the user" do
      it "deletes course" do
        expect { delete_action }.to change(Lesson, :count).by(0)

        delete_action
        expect(response).to redirect_to dashboard_course_lessons_path
      end
    end
  end
end
