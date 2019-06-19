RSpec.describe RegistrationsController, type: :controller do
  describe "GET #new" do
    before { get :new }

    it "renders new view" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      let(:action) { post :create, params: { user: attributes_for(:user) } }

      it "saves a new question in the database" do
        expect { action }.to change(User, :count).by(1)
      end

      it "redirects to show view" do
        action
        expect(response).to redirect_to courses_path
      end
    end

    context "with invalid attributes" do
      let(:action) { post :create, params: { user: attributes_for(:user, :invalid_email) } }

      it "saves a new question in the database" do
        expect { action }.to change(User, :count).by(0)
      end

      it "redirects to show view" do
        action
        expect(response).to render_template :new
      end
    end
  end
end
