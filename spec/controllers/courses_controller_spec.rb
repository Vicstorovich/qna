require "rails_helper"

RSpec.describe CoursesController, type: :controller do
  let(:user) { create :user }

  describe "GET #index" do
    let(:courses) { create_list(:course, 2, user: user)  }

    before { get :index }

    it "fills the array of courses according to pagination" do
      expect(assigns(:courses)).to match_array(courses)

      expect(response).to render_template :index
    end
  end
end
