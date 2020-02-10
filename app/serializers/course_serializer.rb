class CourseSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :type, :course_participant

  def course_participant
    unless current_user == nil
      object.itself.course_users.each do |course|
        @participant = course.user_id == current_user.id
      end

      @participant.equal?(true)
    else
      nil
    end
  end
end
