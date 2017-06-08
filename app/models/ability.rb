class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.new_record?
      can :read, Product, status: Product.statuses[:active]
    elsif user.employee?
      can [:read, :update], Product
    elsif user.management?
      can [:read, :update, :archive], Product
    elsif user.admin?
      can :manage, :all
    end
  end
end
