class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :raise_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :raise_invalid_record
  rescue_from ActionController::UnknownFormat, with: :raise_unknown_format

  def raise_unknown_format
    raise ActionController::RoutingError.new('Not supported format')
  end

  private

  def raise_not_found(exception)
    render json: { error: "#{exception}" }, status: :not_found
  end

  def raise_invalid_record(exception)
    render_active_record_json_error(exception, :unprocessable_entity)
  end

  def render_active_record_json_error(exception, status)
    render json: { error: "#{exception.record.errors.full_messages.to_sentence}" }, status:
  end
end
