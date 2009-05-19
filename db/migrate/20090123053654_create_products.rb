class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :productid
      t.string :title
      t.text :summary
      t.text :description
      t.string :publisher

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
