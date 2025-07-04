# frozen_string_literal: true

module Api
  module Concerns
    module ActAsApiRequest
      extend ActiveSupport::Concern

      included do
        skip_before_action :verify_authenticity_token
        before_action      :disable_session_storage
      end

      private

      def disable_session_storage
        request.session_options[:skip] = true
      end
    end
  end
end
