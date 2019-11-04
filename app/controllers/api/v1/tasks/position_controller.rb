# frozen_string_literal: true

class Api::V1::Tasks::PositionController < ApplicationController
  def update
    task = authorize(Task.find(params[:id]))
    if task_params.present?
      Tasks::UpdatePositionActionService.call(task, task_params)
      render json: TaskSerializer.new(task).serialized_json, status: :ok
    else
      render json: RequestErrorSerializer.new(task.errors), status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:position)
  end
end
