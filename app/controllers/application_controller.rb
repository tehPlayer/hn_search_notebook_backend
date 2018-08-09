# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActionController::ParameterMissing, with: :request_invalid

  def record_not_found
    render json: { status: 'not_found' }, status: 404
  end

  def request_invalid
    render json: { status: 'request_invalid' }, status: 400
  end
end
