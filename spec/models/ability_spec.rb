require 'rails_helper'

RSpec.describe Ability do

  subject(:ability) { Ability.new(user, 'a12d3f5h', "Dashboard") }

  describe 'for guest' do
    let(:user) { nil }
    let(:mentor_role) { create_list(:role, 1, name: 'mentor') }
    let(:other_user) { create(:user, roles: mentor_role) }
    let(:other_course) { create(:course, user: other_user) }


    it { should be_able_to :read, Course }
    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, create(:lesson, course: other_course, share_key: 'a12d3f5h'), user: user }
    it { should_not be_able_to :read, create(:lesson, course: other_course, share_key: 'b12d3f5h'), user: user }
  end

  describe 'for mentor' do
    let(:mentor_role) { create_list(:role, 1, name: 'mentor') }
    let(:user_role) { create_list(:role, 1, name: 'user') }
    let(:user) { create(:user, roles: mentor_role) }
    let(:other_user) { create(:user, roles: mentor_role) }
    let(:student) { create(:user, roles: user_role) }
    let(:other_course) { create(:course, user: other_user) }
    let(:course) { create(:course, user: user) }
    let(:other_lesson) { create(:lesson, course: other_course) }
    let(:lesson) { create(:lesson, course: course) }

    it { should be_able_to :create, Course }
    it { should be_able_to :create, Lesson }
    it { should be_able_to :update, Profile }

    it { should be_able_to :update, create(:course, user: user), user: user }
    it { should_not be_able_to :update, create(:course, user: other_user), user: user }

    it { should be_able_to :update, create(:lesson, course: course), user: user }
    it { should_not be_able_to :update, create(:lesson, course: other_course), user: user }

    it { should be_able_to :destroy, create(:course, user: user), user: user }
    it { should_not be_able_to :destroy, create(:course, user: other_user), user: user }

    it { should be_able_to :destroy, create(:lesson, course: course), user: user }
    it { should_not be_able_to :destroy, create(:lesson, course: other_course), user: user }

    it { should be_able_to :destroy, create(:homework, lesson: lesson, user: student), user: user }
    it { should_not be_able_to :destroy, create(:homework, lesson: other_lesson, user: student), user: user }

    it { should be_able_to :read, create(:homework, lesson: lesson, user: student), user: user }
    it { should_not be_able_to :read, create(:homework, lesson: other_lesson, user: student), user: user }

    it { should be_able_to :share_lesson, create(:lesson, course: course), user: user }
    it { should_not be_able_to :share_lesson, create(:lesson, course: other_course), user: user }

    it { should be_able_to :read, create(:lesson, course: other_course, share_key: 'a12d3f5h'), user: user }
    it { should_not be_able_to :read, create(:lesson, course: other_course, share_key: 'b12d3f5h'), user: user }
  end

  describe 'for user' do
    let(:mentor_role) { create_list(:role, 1, name: 'mentor') }
    let(:user_role) { create_list(:role, 1, name: 'user') }
    let(:user) { create(:user, roles: user_role) }
    let(:other_user) { create(:user, roles: mentor_role) }
    let(:other_course) { create(:course, user: other_user) }

    it { should be_able_to :read, Course }
    it { should be_able_to :read, Lesson }
    it { should be_able_to :create, Homework }
    it { should be_able_to :update, Profile }
    it { should be_able_to :read, create(:lesson, course: other_course, share_key: 'a12d3f5h'), user: user }
    it { should_not be_able_to :access_to_lesson, create(:lesson, course: other_course, share_key: 'b12dpf5h'), user: user }
  end
end
