# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.super_admin? || user.admin?
      can :manage, :all
    elsif user.regular_user?
      can :read, :all
    elsif user.guest?
      # This should only be able to read the available properties and sold properties
      can :read, AvailableProperty
      can :read, SoldProperty
    end
  end
end
