# frozen_string_literal: true

class Api::V1::TasksController < ApplicationController
  # before_action :authenticate_api_v1_user!
  before_action :set_task,  except: %i[create index update_position update_complete]
  before_action :set_task_id, only: %i[update_position update_complete]
  before_action :set_project, only: %i[create index]

  def index
    render json: TaskSerializer.new(@project.tasks).serialized_json, status: :ok
  end

  def show
    render json: TaskSerializer.new(@task).serialized_json, status: :ok
  end

  def create
    task = @project.tasks.new(task_params)
    if task.save
      render json: TaskSerializer.new(task).serialized_json, status: :created
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  def update
    if Tasks::UpdateActionService.call(@task, task_params)
      render json: TaskSerializer.new(@task).serialized_json, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update_position
    if Tasks::UpdatePositionActionService.call(@task, task_params)
      render json: TaskSerializer.new(@task).serialized_json, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update_complete
    if Tasks::UpdateCompleteActionService.call(@task, task_params)
      render json: TaskSerializer.new(@task).serialized_json, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    render status: :no_content if @task.destroy
  end

  private

  def set_task
    @task = Task.find_by(id: params[:id])
    if @task
      authorize @task
    else
      render status: :no_content
    end
  end

  def set_task_id
    @task = Task.find_by(id: params[:task_id])
    if @task
      authorize @task
    else
      render status: :no_content
    end
  end

  def set_project
    @project = Project.find_by(id: params[:project_id])
    if @project
      authorize @project
    else
      render status: :no_content
    end
  end

  def task_params
    params.require(:data).permit(:name, :deadline, :position, :done)
  end

  def pundit_user
    current_api_v1_user
  end
end
