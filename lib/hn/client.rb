# frozen_string_literal: true

module HN
  class Client
    URL = 'https://hn.algolia.com/'
    API_VERSION = 'v1'

    def call_api(endpoint, params = {})
      conn = Faraday.new(url: URL) do |faraday|
        faraday.request  :url_encoded
        # faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end

      path = build_path(endpoint, params)
      response = conn.get(path)

      Results.new(response)
    end

    private

    def base_path
      "api/#{API_VERSION}/"
    end

    def build_path(endpoint, params)
      path = base_path + endpoint
      path += "?#{params.to_query}" if params.present?
      path
    end
  end
end
