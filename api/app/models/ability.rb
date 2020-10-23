class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    user ||= User.new

    if user&.class == User
      can :manage, User, id: user.id
      can :read, Event
    elsif user&.class == Superuser
      can :manage, User
      can :manage, Superuser
      can :manage, Event
    end
  end
end
