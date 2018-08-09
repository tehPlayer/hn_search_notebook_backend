# frozen_string_literal: true

module ControllerSupport
  def response_json
    JSON.parse(response.body).deep_symbolize_keys
  end
end
