# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from Pundit::NotAuthorizedError, with: :not_authorize
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :invalid_params

  private

  def not_authorize
    render json: { error: 'Access Denied' }, status: 403
  end

  def not_found
    render json: { error: 'Not found' }, status: 404
  end

  def invalid_params
    render json: { error: 'Bad request' }, status: 400
  end
end
