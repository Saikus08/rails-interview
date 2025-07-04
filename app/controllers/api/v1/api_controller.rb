# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      include Pagy::Backend
      include Api::Concerns::ActAsApiRequest
      include Api::Concerns::ActAsCrudActions
      include Api::Concerns::ActAsApiErrorHandler
      include Api::Concerns::ActAsRenderer
    end
  end
end
