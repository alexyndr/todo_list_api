class Api::V1::UsersController < ApplicationController
  def show
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      render json: user, status: :ok
    else
      render status: :unauthorized
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation)
  end
end