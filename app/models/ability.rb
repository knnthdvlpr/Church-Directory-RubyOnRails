class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      # Admin can manage everything
      can :manage, :all
    else
      # Members can only read their own profile
      can :read, User, id: user.id
      can :update, User, id: user.id
      
      # Members can view branches and departments
      can :read, Branch
      can :read, Department
      can :read, Position
    end
  end
end