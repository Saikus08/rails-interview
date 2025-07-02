# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TodoListsController, type: :request do
  subject(:api_request) { get api_todo_list_path(params[:id]), as: :json }

  let!(:todo_list) { TodoList.create(name: 'Esto es un todolist') }
  let(:params)     { { id: todo_list.id } }

  before { api_request }

  context 'when request is successful' do
    it 'returns todo list record passed issued by ID' do
      json_response = JSON.parse(response.body).with_indifferent_access

      expect(json_response[:todo_list]).to include('id'=> todo_list.id)
    end

    it 'returns 302 found status code' do
      expect(response).to have_http_status(:found)
    end
  end

  context 'when request is invalid' do
    let(:params) { { id: 999 } }

    it 'returns error saying the record was not found' do
      json_response = JSON.parse(response.body).with_indifferent_access
      expect(json_response[:error]).to include("Couldn't find TodoList with 'id'=#{params[:id]}")
    end

    it 'returns 404 not found status code' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
