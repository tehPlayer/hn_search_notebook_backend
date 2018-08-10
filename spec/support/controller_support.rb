# frozen_string_literal: true

module ControllerSupport
  def response_json
    body = JSON.parse(response.body)

    if body.is_a?(Array)
      body.map(&:deep_symbolize_keys)
    else
      body.deep_symbolize_keys
    end
  end
end
