# Terminar API, completar endpoints con correspondientes tests
# Pensar en grande con millones de registros, implementar
# funcionalidad donde parado en una toodlist puedo completar todos los todoitems. Como no seria un problema de performance

# Hacer el todolist con hotwire.
module Api
  class TodoListsController < ApplicationController
    before_action :set_todo_list

    # GET /api/todolists
    def index
      @todo_lists = TodoList.all

      respond_to :json
    end

    def show
      render json: { todo_list: @todo_list }, status: :found
    end

    def create

    end

    def destroy

    end

    private

    def permitted_params
      params.require(:todo_list).permit(:name)
    end

    def set_todo_list
      @todo_list ||= TodoList.find(params[:id])
    end

    def create_todo_list
      @new_todo_list ||= TodoList.new(permitted_params)
    end
  end
end
