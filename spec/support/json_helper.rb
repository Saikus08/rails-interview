# frozen_string_literal: true

module JsonHelper
  def json_response
    parsed_response = JSON.parse(response.body)

    if parsed_response.is_a?(Hash)
      parsed_response.with_indifferent_access
    else
      parsed_response
    end
  end
end
