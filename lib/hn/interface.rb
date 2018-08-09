# frozen_string_literal: true

module HN
  class Interface
    class << self
      def items(id)
        call_api("items/#{id}")
      end

      def users(username)
        call_api("users/#{username}")
      end

      def search(search_params)
        call_api('search', search_params)
      end

      private

      def call_api(*args)
        HN::Client.new.call_api(*args)
      end
    end
  end
end
