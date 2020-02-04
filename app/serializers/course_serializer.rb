class CourseSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :type, :course_participant

  def course_participant
    current_user.not_participate_in_course?(course)
  end

  def course
    object.itself
  end
end
