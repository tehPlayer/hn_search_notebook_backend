# frozen_string_literal: true

module HN
  class Results
    attr_reader :response

    def initialize(response)
      @response = response
    end

    def url
      @url ||= response.env.url
    end

    def body
      @body ||= JSON.parse(response.body) if response.status == 200
    end
  end
end
