# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def belongs_to_user?
    @record.task.project.user.eql?(@user)
  end

  def index?
    belongs_to_user?
  end

  def show?
    belongs_to_user?
  end

  def create?
    belongs_to_user?
  end

  def new?
    create?
  end

  def update?
    belongs_to_user?
  end

  def edit?
    update?
  end

  def destroy?
    belongs_to_user?
  end
end
