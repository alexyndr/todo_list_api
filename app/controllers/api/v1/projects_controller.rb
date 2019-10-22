class Api::V1::ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, except: [:create, :index]

  def index
    projects = current_user.projects
    render json: ProjectSerializer.new(projects).serialized_json, status: :ok
  end

  def show
    render json: ProjectSerializer.new(@project).serialized_json, status: :ok
  end

  def create
    project = current_user.projects.new(project_params)
    if project.save
      render json: ProjectSerializer.new(project).serialized_json, status: :created
    else
      render json: project.errors, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      render json: ProjectSerializer.new(@project).serialized_json, status: :ok
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  def destroy
    render status: :no_content if @project.destroy
  end

  private

  def set_project
    @project = Project.find_by(id: params[:id])
    if @project
      authorize @project
    else
      render status: :no_content
    end
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
