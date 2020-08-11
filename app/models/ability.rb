# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud
    can :crud, Project, user_id: user.id
    can :crud, Task, project_id: user.projects.pluck(:id)
    can :crud, Comment, user_id: user.id
  end
end
