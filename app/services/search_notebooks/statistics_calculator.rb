# frozen_string_literal: true

module SearchNotebooks
  class StatisticsCalculator
    def initialize(search_notebook_id)
      @search_notebook_id = search_notebook_id
    end

    def calculate!
      queries.map do |query, records|
        {
          query_string: query,
          last_week: calculate_average(records),
          last_day: calculate_average(extract_last_day(records))
        }
      end
    end

    private

    def last_week_queries
      @last_week_queries ||= \
        SearchQuery.joins(search_result: :search_notebook).
        where(search_notebooks: {id: @search_notebook_id}).
        where('search_queries.created_at > ?', 7.days.ago.beginning_of_day).
        to_a
    end

    def queries
      @queries ||= last_week_queries.group_by(&:query_string)
    end

    def extract_last_day(records)
      records.select{|q| q.created_at > 1.day.ago.beginning_of_day}
    end

    def calculate_average(records)
      if records.empty?
        0.0
      else
        size = records.size
        total_hits = records.sum(&:hits)
        total_hits / size.to_f
      end
    end
  end
end