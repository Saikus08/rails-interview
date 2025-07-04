# frozen_string_literal: true

module ActAsParams
  extend ActiveSupport::Concern

  private

  def permitted_params
    params.require(resource_name.to_sym).permit(permitted_columns)
  end

  def permitted_columns
    class_resource.column_names.map(&:to_sym) - excluded_columns
  end

  def excluded_columns
    %i[id created_at updated_at]
  end
end
