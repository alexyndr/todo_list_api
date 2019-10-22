# frozen_string_literal: true

class Tasks::UpdateActionService
  def self.call(task, params)
    update_task_name(task, params) unless params[:done] || params[:position]
  end

  def self.update_task_name(task, params)
    task.update(params)
    task
  end
end
