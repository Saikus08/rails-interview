# frozen_string_literal: true

module Api
  module Concerns
    module ActAsCrudActions
      extend ActiveSupport::Concern

      included do
        before_action :set_resource, only: %i[show update destroy]
      end

      def index
        resources = apply_scopes(class_resource.all)
        pagy, records = pagy(resources, items: per_page)
        render_json_with_serializer(records, meta: pagy_metadata(pagy))
      end

      def show
        render_json_with_serializer(resource)
      end

      def create
        new_record = respond_to?(:create_resource, true) ? create_resource : class_resource.create!(permitted_params)
        render_json_with_serializer(new_record, status: :created)
      end

      def update
        resource.update!(permitted_params)
        render_json_with_serializer(resource)
      end

      def destroy
        resource.destroy!
        head :no_content
      end

      private

      def apply_scopes(scope)
        scope
      end

      def per_page
        [[params[:per_page].to_i, 100].min, 1].max rescue 25
      end

      def set_resource
        instance_variable_set("@#{resource_name}", class_resource.find(params[:id]))
      end

      def resource
        instance_variable_get("@#{resource_name}")
      end
    end
  end
end
