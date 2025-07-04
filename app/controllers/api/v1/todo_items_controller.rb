# frozen_string_literal: true

module Api
  module V1
    class TodoItemsController < ApiController
      def bulk_update
        items = TodoItem.where(id: todo_item_ids)
        result = TodoItems::BulkUpdate.new(todo_items: items, params: permitted_params.to_h).call

        if result.success?
          render json: { updated_count: result.object[:updated_count] }, status: :ok
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
      end

      private

      def todo_item_ids
        params.require(:todo_item_ids)
      end

      def apply_scopes(scope)
        scope.where(todo_list_id: params[:todo_list_id])
      end

      def create_resource
        todo_list.todo_items.create!(permitted_params)
      end

      def todo_list
        @todo_list ||= TodoList.find(params[:todo_list_id])
      end
    end
  end
end
