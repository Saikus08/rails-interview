# frozen_string_literal: true

RSpec.shared_examples 'an API CRUD controller' do |factory:, model:, attributes:, parent_resources: {}|
  let!(:record) { create(factory) }

  let(:parent_instances) do
    parent_resources.transform_values do |factory|
      create(factory)
    end
  end

  let(:url) do
    base = "/api/v1"
    parents_path = parent_instances.map do |key, instance|
      "#{key.to_s.pluralize}/#{instance.id}"
    end.join('/')

    [base, parents_path, model.to_s.pluralize].reject(&:blank?).join('/')
  end

  describe 'GET #index' do
    it 'returns a list' do
      get url
      expect(response).to have_http_status(:ok)
      expect(json[model.to_s.pluralize]).not_to be_empty
    end
  end

  describe 'GET #show' do
    it 'returns the record' do
      get "#{url}/#{record.id}"
      expect(response).to have_http_status(:ok)
      expect(json[model.to_s]).to include('id' => record.id)
    end
  end

  describe 'POST #create' do
    it 'creates a record' do
      post url, params: { model => attributes }
      expect(response).to have_http_status(:created)
      expect(json[model.to_s]['id']).to be_present
    end
  end

  describe 'PATCH #update' do
    it 'updates the record' do
      patch "#{url}/#{record.id}", params: { model => attributes }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the record' do
      delete "#{url}/#{record.id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
