class CourseSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :type, :course_participant

  def course_participant
    return nil if current_user.blank?

    object.itself.course_users.any? do |course|
      course.user_id == current_user.id
    end
  end
end
