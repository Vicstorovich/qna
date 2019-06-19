RSpec.describe CoursesController, type: :controller do
  let(:course) { create :course, name: "MyCourse" }

  #  describe "GET #index" do
  #   let(:questions) { create_list(:question_s, 2) }
  #   before { get :index }
  #   it "populates an array of all questions" do
  #     expect(assigns(:questions)).to match_array(questions)
  #   end

  #   it "renders index view" do
  #     expect(response).to render_template :index
  #   end
  # end

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
      let(:action) { post :create, params: { course: attributes_for(:course, :invalid) } }

      it "does not save the course" do
        expect { action }.to_not change(Course, :count)
      end

      it "re-renders new view" do
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
      before { patch :update, params: { id: course, course: attributes_for(:course, :invalid) } }

      it "does not change course" do
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
      end

      it "redirects to questions index" do
        delete_action
        expect(response).to redirect_to courses_path
      end
    end
  end
end
