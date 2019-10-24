# frozen_string_literal: true

class Api::V1::Tasks::PositionController < ApplicationController
  def update
    task = authorize(find_task)
    if Tasks::UpdatePositionActionService.call(task, task_params)
      render json: TaskSerializer.new(task).serialized_json, status: :ok
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :deadline, :position, :done)
  end

  def find_task
    Task.find(params[:id])
  end
end
