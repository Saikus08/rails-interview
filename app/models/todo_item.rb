# frozen_string_literal: true

class TodoItem < ApplicationRecord
  enum :status, %i[to_do in_progress done]

  belongs_to :todo_list

  validates :title, presence: true
end
