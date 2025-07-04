# frozen_string_literal: true

class TodoListSerializer < ApplicationSerializer
  attributes %i[id name description status due_date]

  has_many :todo_items

  attribute :completed_count do
    object.todo_items.completed.count
  end

  attribute :pending_count do
    object.todo_items.active.count
  end
end
