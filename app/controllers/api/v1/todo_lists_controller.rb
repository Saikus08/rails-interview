# frozen_string_literal: true

module Api
  module V1
    class TodoListsController < ApiController
      def complete_all_items
        resource.todo_items.active.find_each do |item|
          item.update!(status: :done)
        end

        render_json_with_serializer(resource)
      end
    end
  end
end
