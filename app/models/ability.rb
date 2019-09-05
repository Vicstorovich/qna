class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user, share_key, controller_namespace)
    @user = user

    can :read, Lesson do |lesson|
      share_key.present? && share_key == lesson.share_key
    end

    case controller_namespace
    when 'Dashboard'
      mentor_abilities if user.has_role?(:mentor)
    else
      if user.present? && user.has_role?(:user)
        user_abilities
      else
        guest_abilities
      end
    end
  end

  def guest_abilities
    can :read, Course
  end

  def mentor_abilities
    can [:destroy, :read], Homework do |homework|
      homework.lesson.course.user.id == user.id
    end

    can :manage, Course do |course|
      course.user == user || course.course_users.where(user: user).any?
    end

    can :create, Course

    can :manage, Lesson do |lesson|
      lesson.course.user == user
    end

    can :share_lesson, Lesson do |lesson|
      lesson.course.user == user
    end
  end

  def user_abilities
    can :update, Profile
    can :create, Homework
    can :read, Lesson
    can :read, Course

    can :access_to_lesson, Course do |course, lesson|
      course.lesson_available_user?(lesson, user)
    end

    can :access_to_course, Course do |course|
      course.user_not_participant?(user)
    end

    can :opportunity_participate_course, Course do |course|
      !user.not_participate_in_course?(course) || !course.user_not_participant?(user)
    end

    can :learning_lessons_course, Course do |course|
      user.not_participate_in_course?(course) && course.user_not_participant?(user)
    end
  end
end
