# frozen_string_literal: true

module Api
  module V1
    class TodoItemsController < ApiController
      private

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
