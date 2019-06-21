require "rails_helper"

RSpec.describe CoursesController, type: :controller do
  let(:course) { create :course, name: "MyCourse" }

  describe "GET #index" do
    # let(:courses) { create_list(:course, 2) }
    # before { get :index }

    # it "fills the array of courses according to pagination" do
    #   expect(assigns(:courses).page.per(1)).to_not match_array(courses)
    #   expect(assigns(:courses).page.per(2)).to match_array(courses)
    #   expect(assigns(:courses).page.per(3)).to match_array(courses)
    # end

    # it "renders index view" do
    #   expect(response).to render_template :index
    # end
  end

  describe "GET #new" do
    before { get :new }

    it "renders new view" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:action) { post :create, params: { course: attributes_for(:course) } }

      it "saves a new course in the database" do
        expect { action }.to change(Course, :count).by(1)
      end

      it "redirects to show view" do
        action
        expect(response).to redirect_to courses_path
      end
    end

    context "with invalid attributes" do
      let(:action) { post :create, params: { course: attributes_for(:course, name: nil) } }

      it "does not save the course" do
        expect { action }.to_not change(Course, :count)

        action
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    before { get :edit, params: { id: :course } }

    it "renders edit view" do
      expect(response).to render_template :edit
    end
  end

  describe "PATCH #update" do

    context "with valid attributes" do

      it "assigns the requested course to @course" do
        patch :update, params: { id: course, course: attributes_for(:course) }
        expect(assigns(:course)).to eq course
      end

      it "changes course attributes" do
        expect(course.name).to eq "MyCourse"
        patch :update, params: { id: course, course: { name: "new name" } }
        course.reload

        expect(course.name).to eq "new name"
      end

      it "redirects to updated course" do
        patch :update, params: { id: course, course: attributes_for(:course) }

        expect(response).to redirect_to courses_path
      end
    end

    context "with invalid attributes" do
      before { patch :update, params: { id: course, course: attributes_for(:course, name: nil) } }

      it "does not change course" do
        expect(course.name).to eq "MyCourse"
        course.reload

        expect(course.name).to eq "MyCourse"
      end

      it "re-renders edit view" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:course) { create(:course) }
    let(:delete_action) { delete :destroy, params: { id: course } }

    context "if question belongs to the user" do
      it "deletes course" do
        expect { delete_action }.to change(Course, :count).by(-1)

        delete_action
        expect(response).to redirect_to courses_path
      end
    end
  end
end
