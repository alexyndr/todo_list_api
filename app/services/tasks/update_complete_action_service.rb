class Tasks::UpdateCompleteActionService
  def self.call(task, params)
    status_done(task) if params[:done]
  end

  def self.status_done(task)
    task.update(done: true)
    task
  end
end