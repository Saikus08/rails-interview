# frozen_string_literal: true

class Service
  def self.call(*args, **kwargs)
    new(*args, **kwargs).call
  rescue StandardError => e
    ServiceResult.new(errors: e.message)
  end
end
