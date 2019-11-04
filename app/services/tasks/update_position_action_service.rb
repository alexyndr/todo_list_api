# frozen_string_literal: true

class Tasks::UpdatePositionActionService
  def self.call(task, params)
    task.insert_at(params[:position].to_i)
    task
  end
end
