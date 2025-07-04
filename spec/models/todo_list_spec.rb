# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TodoList, type: :model do
  describe 'associations' do
    it { should have_many(:todo_items).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:description).is_at_most(500) }

    it 'validates that due_date is in the future' do
      list = build(:todo_list, due_date: 1.day.ago)
      expect(list).not_to be_valid
      expect(list.errors[:due_date]).to include(/must be greater than/)
    end
  end

  describe 'scopes' do
    it 'returns only active todo lists' do
      active_list_1 = create(:todo_list, status: :incomplete)
      active_list_2 = create(:todo_list, status: :in_progress)
      create(:todo_list, status: :archived)

      expect(TodoList.active).to contain_exactly(active_list_1, active_list_2)
    end

    it 'returns only archived todo lists' do
      archived_list = create(:todo_list, status: :archived)
      create(:todo_list, status: :incomplete)

      expect(TodoList.archived).to contain_exactly(archived_list)
    end
  end

  describe '#complete_all_items!' do
    it 'marks all items as done' do
      list = create(:todo_list)
      create(:todo_item, todo_list: list, status: :to_do)
      create(:todo_item, todo_list: list, status: :in_progress)

      list.complete_all_items!

      expect(list.todo_items.pluck(:status).uniq).to eq(['done'])
    end
  end
end
