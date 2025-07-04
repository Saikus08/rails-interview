# frozen_string_literal: true

class TodoItem < ApplicationRecord
  enum :status, %i[to_do in_progress done]

  belongs_to :todo_list, inverse_of: :todo_items

  after_update :mark_list_as_completed_if_all_done, if: :saved_change_to_status?

  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :due_date, comparison: { greater_than: -> { Time.current } }, allow_blank: true
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

  def mark_list_as_completed_if_all_done
    return unless status.to_sym == :done
    return unless todo_list.todo_items.active.none?

    todo_list.update!(status: :completed)
  end
end
