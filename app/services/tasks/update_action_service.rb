# frozen_string_literal: true

class Tasks::UpdateActionService
  def self.call(task, params)
    position_change(task, params) if params[:position]
    status_done(task) if params[:done]
    update_task_name(task, params) unless params[:done] || params[:position]
    task
  end

  def self.update_task_name(task, params)
    task.update(params)
  end

  def self.position_change(task, parameter)
    task.insert_at(parameter[:position].to_i)
  end

  def self.status_done(task)
    task.update(done: true)
  end
end
