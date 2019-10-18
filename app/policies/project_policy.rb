# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  def belongs_to_user?
    @record.user.eql?(@user)
  end
end
