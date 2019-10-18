class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:create, :index]
  before_action :set_comment, except: [:create, :index]

  def index
    render json: CommentSerializer.new(@task.comments).serialized_json, status: :ok
  end

  def create
    comment = @task.comments.new(comment_params)
    if comment.save
      render json: CommentSerializer.new(comment).serialized_json, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    render status: :no_content if @comments.destroy
  end

  private

  def set_task
    @task = Task.find_by(id: params[:task_id])
    if @task
      authorize @task
    else
      render status: :no_content
    end
  end

  def set_comment
    @comments = Comment.find_by(id: params[:id])
    if @comments
      authorize @comments
    else
      render status: :no_content
    end
  end

  def comment_params
    params.require(:data).permit(:body, :file)
  end
end
