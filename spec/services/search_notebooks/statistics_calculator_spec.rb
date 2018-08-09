# frozen_string_literal: true

require 'rails_helper'

describe SearchNotebooks::StatisticsCalculator do
  let(:search_notebook) { create(:search_notebook) }
  let(:query) { "http://localhost:3000" }
  let(:search_query1) { create(:search_query, query_string: query, hits: 400) }
  let(:search_query2) { create(:search_query, query_string: query, hits: 300) }
  let(:search_query3) do
    create(:search_query, query_string: query, hits: 200, created_at: 1.day.ago)
  end
  let(:search_query4) do
    create(:search_query, query_string: query, hits: 100, created_at: 3.days.ago)
  end
  let(:search_query5) do
    create(:search_query, query_string: query, hits: 50, created_at: 8.days.ago)
  end
  before do
    5.times do |x|
      create(
        :search_result,
        search_query: send("search_query#{x + 1}"),
        search_notebook: search_notebook
      )
    end
  end

  it 'correctly calculates statistics' do
    service = described_class.new(search_notebook.id)
    expect(service.calculate!).to eq(
      [
        {
          query_string: query,
          last_day: 300.0,
          last_week: 250.0
        }
      ]
    )
  end
end