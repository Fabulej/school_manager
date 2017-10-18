class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, User
      can :manage, SchoolClass
      can :manage, Subject
      can :read, Grade
    elsif user.teacher?
      can :manage, Grade
      cannot :index, Grade
      can :read, Subject do |subject|
        subject.teacher == user
      end
      can [:read, :update], User, id: user.id
      cannot :index, User
    elsif user.student?
      can [:read, :update], User, id: user.id
      cannot :index, User
      can :read, Grade, user_id: user.id
    end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
