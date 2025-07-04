# frozen_string_literal: true

module Api
  module Concerns
    module ActAsApiErrorHandler
      extend ActiveSupport::Concern
      include ::ActAsErrorHandler

      private

      def respond_with_error(exception, status)
        errors =
          case exception
          when ActionController::ParameterMissing
            [I18n.t('errors.parameter_missing')]
          when ActionController::RoutingError
            [I18n.t('errors.routing_error')]
          when ActiveRecord::RecordNotFound
            [I18n.t('errors.record_not_found')]
          when ActiveRecord::RecordNotUnique
            [I18n.t('errors.record_not_unique')]
          when ActiveRecord::RecordInvalid, ActiveRecord::RecordNotSaved
            exception.record&.errors&.full_messages.presence || [exception.message]
          else
            [I18n.t('errors.standard_error')]
          end

        render json: { status: :error, errors: errors }, status:
      end
    end
  end
end
