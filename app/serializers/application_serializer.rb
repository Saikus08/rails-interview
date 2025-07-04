# frozen_string_literal: true

class ApplicationSerializer < ActiveModel::Serializer
  def self.column_names
    model.column_names.sort.map(&:to_sym) - %i[created_at updated_at]
  rescue NoMethodError
    []
  end

  def self.model
    self.name.gsub(/Simple|Serializer|All/, '').constantize
  rescue NameError
    NilClass
  end
end
