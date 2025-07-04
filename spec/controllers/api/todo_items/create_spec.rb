# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TodoItemsController, type: :request do
  # subject(:api_request) { post api_todo_list_todo_items_path(todo_list.id), params:, as: :json }

  # let(:todo_list) { TodoList.create(name: 'Todo list') }
  # let(:params)    { { todo_item: { title: 'New todo item' } } }

  # before { api_request }

  # context 'when valid todo_list is issued' do
  #   context 'when valid parameters are sent to the request' do
  #     it 'creates a new todo item for the given todo list' do
  #       json_response = JSON.parse(response.body).with_indifferent_access

  #       expect(json_response[:todo_item][:todo_list_id]).to eq(todo_list.id)
  #       expect(json_response[:todo_item][:title]).to eq(params[:todo_item][:title])
  #     end

  #     it 'returns 201 created status code' do

  #     end
  #   end

  #   context 'when invalid parameters are sent to the request' do
  #     let(:params) { {title: nil} }

  #     it 'returns 422 unprocessable entity status code' do

  #     end
  #   end
  # end

  # context 'when invalid todo_list is issued' do
  #   it 'returns 404 error todo list not found' do
  #   end
  # end
end
