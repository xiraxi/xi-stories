class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string    :title
      t.datetime  :date
      t.text      :intro
      t.text      :content
      t.integer   :section_id
      t.boolean   :draft
      t.boolean   :breaking
      t.integer   :user_id
      t.integer   :author_id
      t.datetime  :deleted_at
      t.string    :cached_tag_list, :limit => 4000
      t.string    :lang

      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
