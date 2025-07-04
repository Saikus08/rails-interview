class TodoListsController < ApplicationController
  # GET /todolists
  def index
    @todo_lists = TodoList.all

    respond_to :html
  end

  # GET /todolists/new
  def new
    @todo_list = TodoList.new

    respond_to :html
  end

  def show
    @todo_list = TodoList.find(params[:id])
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
