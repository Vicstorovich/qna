RSpec.describe SessionsController, type: :controller do
  describe "POST #create" do
    let!(:user) { create :user, email: "valid@test.com", password: "valid_password" }

    context "when valid email and password"  do
      before { post :create, params: { email: "valid@test.com", password: "valid_password" } }

      it "should login and redirect to home page" do
        expect(session[:user_id]).to eq user.id
        expect(response).to redirect_to courses_path
        expect(response).to_not render_template :new
      end
    end

    context "when valid email but invalid password"  do
      before { post :create, params: { email: "valid@test.com", password: "invalid_password" } }

      it "should not login and render sign it form" do
        expect(session[:user_id]).to eq nil
        expect(response).to_not redirect_to courses_path
        expect(response).to render_template :new
      end
    end

    context "when invalid email"  do
      before { post :create, params: { email: "invalid@test.com", password: "valid_password" } }

      it "should not login and render sign it form" do
        expect(session[:user_id]).to_not eq user.id
        expect(response).to_not redirect_to courses_path
        expect(response).to render_template :new
      end
    end
  end
end
