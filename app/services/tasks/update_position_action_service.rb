class Tasks::UpdatePositionActionService
  def self.call(task, params)
    position_change(task, params) if params[:position]
  end

  def self.position_change(task, parameter)
    task.insert_at(parameter[:position].to_i)
    task
  end
end