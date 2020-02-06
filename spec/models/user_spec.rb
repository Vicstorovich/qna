require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user, password: '1234567' }

  it { should have_many(:courses) }
end
