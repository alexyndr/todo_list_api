# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit
  include DeviseTokenAuth::Concerns::SetUserByToken

  rescue_from Pundit::NotAuthorizedError, with: :not_authorize
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_authorize
    render json: { error: 'Access Denied' }, status: 403
  end

  def not_found
    render json: { error: 'Not found' }, status: 404
  end
end
