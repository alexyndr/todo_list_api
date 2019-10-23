# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit
  include DeviseTokenAuth::Concerns::SetUserByToken
  # rescue from not found
  # rescue from not authorize
end
