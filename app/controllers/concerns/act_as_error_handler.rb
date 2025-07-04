# frozen_string_literal: true

module ActAsErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError,                      with: :handle_standard_error
    rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing
    rescue_from ActionController::RoutingError,     with: :handle_routing_error
    rescue_from ActiveRecord::RecordNotFound,       with: :handle_record_not_found
    rescue_from ActiveRecord::RecordInvalid,        with: :handle_record_invalid
    rescue_from ActiveRecord::RecordNotSaved,       with: :handle_record_invalid
    rescue_from ActiveRecord::RecordNotUnique,      with: :handle_conflict
  end

  private

  def handle_standard_error(exception)
    respond_with_error(exception, :bad_request)
  end

  def handle_parameter_missing(exception)
    respond_with_error(exception, :bad_request)
  end

  def handle_routing_error(exception)
    respond_with_error(exception, :bad_request)
  end

  def handle_record_not_found(exception)
    respond_with_error(exception, :not_found)
  end

  def handle_record_invalid(exception)
    respond_with_error(exception, :unprocessable_entity)
  end

  def handle_conflict(exception)
    respond_with_error(exception, :conflict)
  end
end
