# frozen_string_literal: true

module Api
  module Concerns
    module ActAsRenderer
      extend ActiveSupport::Concern

      private

      def render_json_with_serializer(object, status: :ok, serializer: nil, meta: nil)
        serializer ||= default_serializer_for(object)

        render json: serialized(object, serializer).merge(meta:).compact, status:
      end

      def serialized(object, serializer)
        Rails.logger.debug("Serializing #{object.class.name} with: #{serializer}")

        if object.respond_to?(:to_ary)
          {
            "#{resource_name.pluralize}": ActiveModelSerializers::SerializableResource.new(
              object, each_serializer: serializer, **serializer_options
            )
          }
        else
          {
            "#{resource_name}": serializer.new(object, serializer_options)
          }
        end
      end

      def default_serializer_for(object)
        model_class =
          if object.respond_to?(:to_ary)
            # para arrays o ActiveRecord::Relation
            object.first.class rescue nil
          else
            object.class
          end

        raise NameError, "Serializer not found: #{model_class}" unless model_class

        "#{model_class}Serializer".constantize
      end


      def serializer_options
        {}
      end
    end
  end
end
