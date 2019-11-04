# frozen_string_literal: true

class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    task = authorize(set_task)
    render json: CommentSerializer.new(task.comments).serialized_json, status: :ok
  end

  def create
    comment = authorize(set_task).comments.new(comment_params)
    if comment.save
      render json: CommentSerializer.new(comment).serialized_json, status: :created
    else
      render json: RequestErrorSerializer.new(comment.errors), status: :unprocessable_entity
    end
  end

  def destroy
    comment = authorize(set_comment)
    comment.destroy
  end

  private

  def set_task
    Task.find(params[:task_id])
  end

  def set_comment
    Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :file)
  end
end
