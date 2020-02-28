class CourseSerializer < ActiveModel::Serializer
  attributes :id, :name, :type, :course_participant

  def course_participant
    return nil if current_user.blank?

    user_participant? if object.itself.respond_to?(:pupil)
  end

  def user_participant?
    object.itself.pupil ? true : false
  end
end
