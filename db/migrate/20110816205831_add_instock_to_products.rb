class AddInstockToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :in_stock, :boolean, :default => true
  end

  def self.down
    remove_column :products, :in_stock
  end
end
