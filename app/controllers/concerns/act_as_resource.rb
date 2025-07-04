# frozen_string_literal: true

module ActAsResource
  extend ActiveSupport::Concern

  included do
    before_action :set_resource_name
  end

  private

  def set_resource_name
    @resource_name = controller_name.singularize
  end

  def resource_name
    @resource_name
  end

  def class_resource
    controller_name.classify.constantize
  end
end
