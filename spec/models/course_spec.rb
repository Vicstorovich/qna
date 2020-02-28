require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(3) }

  it 'mount_uploader image' do
    expect(Course.new.image).to be_an_instance_of(CourseImageUploader)
  end
end
