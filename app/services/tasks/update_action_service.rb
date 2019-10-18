class Tasks::UpdateActionService
  PARAM = {
    up: 'up',
    down: 'down',
    done: 'done'
  }.freeze

  def self.call(task, params)
    case true
    when params[:position].present? then position_change(params[:position], task)
    when params[:done].present? then done(params[:done], task)
    when !params[:done] && !params[:position] then task.update(params)
    end
  end

  def self.position_change(parameter, task)
    case parameter
    when PARAM[:up] then task.move_higher
    when PARAM[:down] then task.move_lower
    end
  end

  def self.done(parameter, task)
    task.update(done: true) if parameter == PARAM[:done]
  end
end