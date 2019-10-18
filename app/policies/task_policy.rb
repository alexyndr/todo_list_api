# frozen_string_literal: true

class TaskPolicy < ApplicationPolicy
  def belongs_to_user?
    @record.project.user.eql?(@user)
  end
end
