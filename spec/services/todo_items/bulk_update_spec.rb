# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TodoItems::BulkUpdate, type: :service do
  subject(:service_call) { described_class.call(todo_items: items, params:) }

  describe '#call' do
    let!(:todo_list) { create(:todo_list) }
    let!(:_records)  { create_list(:todo_item, 3, todo_list:) }
    let(:items)      { TodoItem.where(todo_list:) }

    context 'when updating status to done successfully' do
      let(:params) { { status: 'done' } }

      it 'updates all items and returns updated_count' do
        result = service_call

        expect(result).to be_success
        expect(result.object[:updated_count]).to eq(3)
        expect(items.map(&:reload).map(&:status)).to all(eq('done'))
      end
    end

    context 'when no items are provided' do
      let(:items)  { TodoItem.none }
      let(:params) { { status: 'done' } }

      it 'returns error indicating no records' do
        result = service_call

        expect(result).not_to be_success
        expect(result.errors).to include("No records to update")
      end
    end

    context 'when SQL error occurs' do
      let(:params) { { status: 'done' } }

      before do
        allow(TodoItem).to receive(:where).and_return(items)
        allow(items).to receive(:update_all).and_raise(ActiveRecord::StatementInvalid, 'invalid SQL')
      end

      it 'returns error in ServiceResult' do
        result = service_call

        expect(result).not_to be_success
        expect(result.errors).to include('invalid SQL')
      end
    end
  end
end
