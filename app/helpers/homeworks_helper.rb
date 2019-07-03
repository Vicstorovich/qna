module HomeworksHelper
  def author_homework(homework)
    user = User.find_by(id: homework.user_id)
    user.profile.name
  end
end
