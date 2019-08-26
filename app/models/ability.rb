class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.has_role?(:mentor) ? mentor_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, Course
  end

  def mentor_abilities
    user_abilities
    can :destroy, Homework do |homework|
      homework.lesson.course.user.id == user.id
    end
    can :manage, Course do |course|
      course.user == user
    end
    can :manage, Lesson do |lesson|
      lesson.course.user == user
    end
    can :manage, CourseUser
  end

  def user_abilities
    can :read, :all
    can :update, Profile
    can :create, Homework
    can [:create, :destroy], Course
  end
end
