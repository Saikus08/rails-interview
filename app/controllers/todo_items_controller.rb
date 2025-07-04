# froze_string_literal: true

class TodoItemsController < ApplicationController
  before_action :set_todo_list
  before_action :set_todo_item, only: :complete

  def complete_all
    @todo_list.todo_items.update_all(status: :done)
    @todo_list.reload

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @todo_list }
    end
  end

  def complete
    @todo_item.update!(status: :done)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @todo_list }
    end
  end

  private

  def set_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end

  def set_todo_item
    @todo_item = @todo_list.todo_items.find(params[:id])
  end
end
