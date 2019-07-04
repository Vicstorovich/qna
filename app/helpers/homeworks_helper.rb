module HomeworksHelper
  def author_homework(homework)
    user = User.find homework.user_id
    user.profile.name
  end
end
