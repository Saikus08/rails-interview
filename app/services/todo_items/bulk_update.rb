# frozen_string_literal: true

module TodoItems
  class BulkUpdate < Service
    def initialize(todo_items:, params:)
      @todo_items = todo_items
      @params = params
    end

    def call
      return ServiceResult.new(errors: ["No records to update"]) if todo_items.none?

      updated_count = todo_items.update_all(params)
      ServiceResult.new(object: { updated_count: })
    rescue => e
      ServiceResult.new(errors: [e.message])
    end

    private

    attr_reader :todo_items, :params
  end
end
