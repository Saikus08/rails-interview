# frozen_string_literal: true

class TodoItemSerializer < ApplicationSerializer
  attributes %i[id title description status due_date]

  belongs_to :todo_list

  attribute :overdue do
    object.due_date.present? && object.due_date < Time.current && !object.done?
  end
end
