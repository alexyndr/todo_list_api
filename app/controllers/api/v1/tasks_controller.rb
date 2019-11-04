# frozen_string_literal: true

class Api::V1::TasksController < ApplicationController
  def index
    render json: TaskSerializer.new(find_project.tasks).serialized_json, status: :ok
  end

  def show
    task = authorize(find_task)
    render json: TaskSerializer.new(task).serialized_json, status: :ok
  end

  def create
    task = authorize(find_project.tasks.new(task_params))
    if task.save
      render json: TaskSerializer.new(task).serialized_json, status: :created
    else
      render json: RequestErrorSerializer.new(task.errors), status: :unprocessable_entity
    end
  end

  def update
    task = authorize(find_task)
    if task.update(task_params)
      render json: TaskSerializer.new(task).serialized_json, status: :ok
    else
      render json: RequestErrorSerializer.new(task.errors), status: :unprocessable_entity
    end
  end

  def destroy
    task = authorize(find_task)
    task.destroy
  end

  private

  def find_task
    Task.find(params[:id])
  end

  def find_project
    Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:name, :deadline)
  end
end
