# frozen_string_literal: true

module Api
  module Concerns
    module ActAsErrorHandler
      extend ActiveSupport::Concern

      included do
        rescue_from StandardError,                      with: :render_json_error_response
        rescue_from ActionController::ParameterMissing, with: :render_json_error_response
        rescue_from ActionController::RoutingError,     with: :render_json_error_response
        rescue_from ActiveRecord::RecordNotFound,       with: :render_json_record_not_found_response
        rescue_from ActiveRecord::RecordInvalid,        with: :render_json_record_error_response
        rescue_from ActiveRecord::RecordNotUnique,      with: :render_json_conflict_response
        rescue_from ActiveRecord::RecordNotSaved,       with: :render_json_record_error_response
      end

      private

      def render_json_error_response(exception, status = :bad_request)
        error_message = case exception
                        when ActionController::ParameterMissing
                          I18n.t('errors.parameter_missing')
                        when ActionController::RoutingError
                          I18n.t('errors.routing_error')
                        else
                          I18n.t('errors.standard_error')
                        end
        render json: { status: :error, errors: error_message }, status:
      end

      def render_json_record_error_response(exception, status = :unprocessable_entity)
        errors =
          if exception.respond_to?(:record) && exception.record&.respond_to?(:errors)
            exception.record.errors.full_messages
          else
            [exception.message]
          end

        render json: { status: :error, errors: errors }, status:
      end


      def render_json_record_not_found_response(exception, status = :not_found)
        render json: { status: :error, errors: I18n.t('errors.record_not_found') }, status:
      end

      def render_json_conflict_response(exception, status = :conflict)
        render json: { status: :error, errors: I18n.t('errors.record_not_unique') }, status:
      end
    end
  end
end
