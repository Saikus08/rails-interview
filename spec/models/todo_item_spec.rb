# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TodoItem, type: :model do
  describe 'associations' do
    it { should belong_to(:todo_list) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }

    it 'validates due_date before todo_list due_date' do
      list = create(:todo_list, due_date: 3.days.from_now)
      item = build(:todo_item, todo_list: list, due_date: 5.days.from_now)

      expect(item).not_to be_valid
      expect(item.errors[:due_date]).to include(/must be before/)
    end
  end

  describe 'scopes' do
    it 'returns active items (to_do, in_progress)' do
      todo = create(:todo_item, status: :to_do)
      in_progress = create(:todo_item, status: :in_progress)
      create(:todo_item, status: :done)

      expect(TodoItem.active).to contain_exactly(todo, in_progress)
    end

    it 'returns completed items (done)' do
      done = create(:todo_item, status: :done)
      create(:todo_item, status: :to_do)

      expect(TodoItem.completed).to contain_exactly(done)
    end

    it 'returns overdue items (due_date < now and not done)' do
      overdue = create(:todo_item, status: :in_progress, due_date: 2.days.from_now)
      overdue.update_column(:due_date, 1.day.ago)

      done = create(:todo_item, status: :done, due_date: 2.days.from_now)
      done.update_column(:due_date, 1.day.ago)

      upcoming = create(:todo_item, due_date: 2.days.from_now, status: :to_do)

      expect(TodoItem.overdue).to contain_exactly(overdue)
    end

  end

  describe 'callbacks' do
    it 'marks list as completed if all items are done' do
      list = create(:todo_list, status: :incomplete)
      create(:todo_item, todo_list: list, status: :done)
      item = create(:todo_item, todo_list: list, status: :in_progress)

      item.update!(status: :done)

      expect(list.reload.status).to eq('completed')
    end

    it 'does not mark list as completed if any item is not done' do
      list = create(:todo_list, status: :incomplete)
      create(:todo_item, todo_list: list, status: :to_do)
      item = create(:todo_item, todo_list: list, status: :in_progress)

      item.update!(status: :done)

      expect(list.reload.status).not_to eq('completed')
    end
  end
end
