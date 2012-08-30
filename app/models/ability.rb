class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, User, :account_id => user.account_id
      can :manage, Period, :account_id => user.account_id
      can :manage, Review, :account_id => user.account_id
      can :manage, Goal, :user_id => user.id
      can :manage, Progress, :user_id => user.id
      # can :manage, User, :organization_id => user.organization_id
      # can :manage, Physician, :organization_id => user.organization_id
      # can :manage, Patient, :organization_id => user.organization_id
      # can :manage, Appointment, :organization_id => user.organization_id
      # can :manage, Dashboard, :organization_id => user.organization_id
      # can :manage, Account
      # can :manage, User, :account_id => user.account_id
      # can :manage, Period, :account_id => user.account_id
      # can :manage, Review, :account_id => user.account_id
      # can :manage, Goal, :user_id => user.id
      # can :manage, Progress, :user_id => user.id
      # can :manage, Dashboard
    else
      can :manage, User, :id => user.id
      can :manage, Review, :user_id => user.id
      can :manage, Goal, :user_id => user.id
      can :manage, Progress, :user_id => user.id
    end
  end
end
