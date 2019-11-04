# frozen_string_literal: true

class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    projects = current_user.projects
    render json: ProjectSerializer.new(projects).serialized_json, status: :ok
  end

  def show
    project = authorize(set_project)
    render json: ProjectSerializer.new(project).serialized_json, status: :ok
  end

  def create
    project = current_user.projects.new(project_params)
    if project.save
      render json: ProjectSerializer.new(project).serialized_json, status: :created
    else
      render json: RequestErrorSerializer.new(project.errors), status: :unprocessable_entity
    end
  end

  def update
    project = authorize(set_project)
    if project.update(project_params)
      render json: ProjectSerializer.new(project).serialized_json, status: :ok
    else
      render json: RequestErrorSerializer.new(project.errors), status: :unprocessable_entity
    end
  end

  def destroy
    project = authorize(set_project)
    project.destroy
  end

  private

  def set_project
    Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
