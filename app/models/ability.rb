# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.manager?
      # Manager can create projects and manage the projects he created and see the bugs of those projects which are created by him
      can :manage, Project, creator_id: user.id
      can :read, Bug, project_id: user.projects.pluck(:id)
    elsif user.developer?
      # Developer can view bugs he is associated with
      can :read, Bug, id: user.bugs.pluck(:id)
      # Developer can view projects he is associated with
      can :read, Project, id: user.projects.pluck(:id)
    elsif user.qa?
      can :manage, Bug, project_id: user.projects.pluck(:id)
      can %i[create new], Bug
      can :read, Project, id: user.projects.pluck(:id)
    else
      # Default: Guests have no abilities
      cannot :read, Project
      cannot :read, Bug
    end
  end
end

# Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
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
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
