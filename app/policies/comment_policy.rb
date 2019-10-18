class CommentPolicy < ApplicationPolicy
  def belongs_to_user?
    @record.task.project.user.eql?(@user)
  end
end
