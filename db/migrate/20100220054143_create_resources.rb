class CreateResources < ActiveRecord::Migration
  def self.up
    create_table :resources do |t|
      t.string :title
      t.string :category
      t.string :tags
      t.text :summary
      t.text :description
      t.string :url
      t.string :organisation
      t.string :image

      t.timestamps
    end
  end

  def self.down
    drop_table :resources
  end
end
