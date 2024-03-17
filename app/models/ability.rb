# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role == 'super_admin' || user.role == 'admin'
      can :manage, :all
    elsif user.role == 'regular_user'
      can :read, :all
    end
  end
end
