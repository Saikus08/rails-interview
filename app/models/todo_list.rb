# frozen_string_literal: true

class TodoList < ApplicationRecord
  enum :status, %i[incomplete completed archived in_progress]

  has_many :todo_items, dependent: :destroy, inverse_of: :todo_list

  scope :active, -> { where(status: %i[incomplete in_progress]) }
  scope :archived, -> { where(status: :archived) }

  validates :name, presence: true
  validates :description, length: { maximum: 500 }
  validates :due_date, comparison: { greater_than: -> { Time.current } }, allow_blank: true

  def complete_all_items!
    todo_items.where.not(status: :done).update_all(status: TodoItem.statuses[:done])
  end
end
