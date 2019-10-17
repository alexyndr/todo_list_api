class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def index
    projects = current_api_v1_user.projects
    render json: ProjectSerializer.new(projects).serialized_json, status: :ok
  end

  def create
    project = current_api_v1_user.projects.new(project_params)
    if project.save
      render json: ProjectSerializer.new(project).serialized_json, status: :created
    else
      render json: project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @projects.update(project_params)
      render json: ProjectSerializer.new(@projects).serialized_json, status: :ok
    else
      render json: project.errors, status: :unprocessable_entity
    end
  end

  private

  def project_params
    params.require(:data).permit(:name)
  end
end
