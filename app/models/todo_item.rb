# frozen_string_literal: true

class TodoItem < ApplicationRecord
  enum :status, %i[to_do in_progress done]

  belongs_to :todo_list, inverse_of: :todo_items

  validates :title, presence: true
  validate :due_date_before_todo_list_due_date

  scope :active, -> { where(status: %i[to_do in_progress]) }
  scope :completed, -> { where(status: :done) }
  scope :overdue, -> { where('due_date < ? AND status != ?', Time.current, statuses[:done]) }

  private

  def due_date_before_todo_list_due_date
    return if due_date.blank? || todo_list.due_date.blank?

    errors.add(:due_date, :before_todo_list_due_date) if due_date > todo_list.due_date
  end
end
