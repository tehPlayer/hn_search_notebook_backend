# frozen_string_literal: true

module Tags
  class CollectionUpdate < Mutations::Command
    attr_accessor :existing

    required do
      array :new_tags, class: String
      array :current_tags, class: String
    end

    def execute
      lookup
      create
      cleanup

      Tag.where(name: new_tags)
    end

    private

    def lookup
      @existing = Tag.where(name: new_tags).pluck(:name)
    end

    def create
      # We can use AR mass insert if needed
      (new_tags - @existing).each { |t| Tag.create!(name: t) }
    end

    def cleanup
      removed_tags = current_tags - new_tags
      ids_to_check = Tag.where(name: removed_tags).pluck(:id)
      tag_ids_in_use = Tagging.where(tag_id: ids_to_check).pluck(:tag_id)
      unused_ids = ids_to_check - tag_ids_in_use

      Tag.where(id: unused_ids).destroy_all
    end
  end
end
