# frozen_string_literal: true

module Api
  class TodoItemsController < ApplicationController
    before_action :set_todo_list

    def create
      render json: { todo_item: create_todo_item }, status: :created
    end

    private

    def set_todo_list
      @todo_list ||= TodoList.find(params[:todo_list_id])
    end

    def permitted_params
      params.require(:todo_item).permit(:title, :description, :status)
    end

    def create_todo_item
      @todo_item ||= TodoItem.create!(permitted_params.merge(todo_list_id: params[:todo_list_id]))
    end
  end
end
