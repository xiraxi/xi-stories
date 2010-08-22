class CreateStorySections < ActiveRecord::Migration
  def self.up
    create_table :story_sections do |t|
      t.string    :name
      t.integer   :order
      t.datetime  :deleted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :story_sections
  end
end
