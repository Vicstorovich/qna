class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :course_participant

  def course_participant
    return nil if current_user.blank?

    object.itself.pupil if object.itself.respond_to?(:pupil)
  end
end
