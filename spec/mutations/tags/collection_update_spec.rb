# frozen_string_literal: true

require 'rails_helper'

describe Tags::CollectionUpdate do
  subject { described_class.run(params) }

  shared_examples 'new tags created' do
    it 'creates new tags' do
      subject
      expect(Tag.where(name: new_tags).count).to eq(new_tags.size)
    end
  end

  context 'for overlapsing tags' do
    let(:current_tags) { %w{story comment image} }
    let(:new_tags) { %w{story comment video} }
    let(:current_tags_objects) { current_tags.each {|t| Tag.create(name: t)} }
    let(:params) do
      {
        new_tags: new_tags,
        current_tags: current_tags
      }
    end

    it_behaves_like 'new tags created'

    it 'drops unused tags' do
      subject
      expect(Tag.exists?(name: 'image')).to be_falsey
    end
  end

  context 'for totally different tags' do
    let(:current_tags) { %w{home office image} }
    let(:new_tags) { %w{work place video} }
    let(:current_tags_objects) { current_tags.each {|t| Tag.create(name: t)} }
    let(:params) do
      {
        new_tags: new_tags,
        current_tags: current_tags
      }
    end

    it_behaves_like 'new tags created'

    it 'drops unused tags' do
      subject
      expect(Tag.exists?(name: current_tags)).to be_falsey
    end
  end

  context 'for tags used in different objects' do
    let(:current_tags) { %w{home office} }
    let(:new_tags) { %w{work place video} }
    let(:current_tags_objects) { current_tags.each {|t| Tag.create(name: t)} }
    let(:params) do
      {
        new_tags: new_tags,
        current_tags: current_tags
      }
    end
    before do
      create(:search_result, tag_list: ['home'])
    end

    it_behaves_like 'new tags created'

    it 'drops unused tags' do
      subject
      expect(Tag.exists?(name: 'office')).to be_falsey
    end

    it 'keeps used tag' do
      subject
      expect(Tag.exists?(name: 'home')).to be_truthy
    end
  end
end