# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Concerns::ActAsErrorHandler', type: :controller do
  controller(ApplicationController) do
    include Api::Concerns::ActAsErrorHandler

    def param_missing
      raise ActionController::ParameterMissing, :test
    end

    def routing
      raise ActionController::RoutingError.new('Not Found')
    end

    def standard
      raise 'Something went wrong'
    end

    def not_found
      raise ActiveRecord::RecordNotFound, 'Record not found'
    end

    def invalid
      record = TodoList.new # no name
      record.validate!
      raise ActiveRecord::RecordInvalid.new(record)
    end

    def not_unique
      raise ActiveRecord::RecordNotUnique.new('Duplicate')
    end

    def not_saved
      raise ActiveRecord::RecordNotSaved.new('Not saved')
    end
  end

  before do
    routes.draw do
      get 'param_missing' => 'anonymous#param_missing'
      get 'routing' => 'anonymous#routing'
      get 'standard' => 'anonymous#standard'
      get 'not_found' => 'anonymous#not_found'
      get 'invalid' => 'anonymous#invalid'
      get 'not_unique' => 'anonymous#not_unique'
      get 'not_saved' => 'anonymous#not_saved'
    end
  end

  it 'handles ActionController::ParameterMissing' do
    get :param_missing
    expect(response).to have_http_status(:bad_request)
    expect(JSON.parse(response.body)['errors']).to eq(I18n.t('errors.parameter_missing'))
  end

  it 'handles ActionController::RoutingError' do
    get :routing
    expect(response).to have_http_status(:bad_request)
    expect(JSON.parse(response.body)['errors']).to eq(I18n.t('errors.routing_error'))
  end

  it 'handles StandardError' do
    get :standard
    expect(response).to have_http_status(:bad_request)
    expect(JSON.parse(response.body)['errors']).to eq(I18n.t('errors.standard_error'))
  end

  it 'handles ActiveRecord::RecordNotFound' do
    get :not_found
    expect(response).to have_http_status(:not_found)
    expect(JSON.parse(response.body)['errors']).to eq(I18n.t('errors.record_not_found'))
  end

  it 'handles ActiveRecord::RecordInvalid' do
    get :invalid
    expect(response).to have_http_status(:unprocessable_entity)
    expect(JSON.parse(response.body)['errors']).to include("Name can't be blank")
  end

  it 'handles ActiveRecord::RecordNotUnique' do
    get :not_unique
    expect(response).to have_http_status(:conflict)
    expect(JSON.parse(response.body)['errors']).to eq(I18n.t('errors.record_not_unique'))
  end

  it 'handles ActiveRecord::RecordNotSaved' do
    get :not_saved
    expect(response).to have_http_status(:unprocessable_entity)
    expect(json_response['errors']).to include('Not saved')
  end

  it 'handles StandardError' do
    get :standard
    expect(response).to have_http_status(:bad_request)
    expect(json_response['errors']).to eq(I18n.t('errors.standard_error'))
  end
end
