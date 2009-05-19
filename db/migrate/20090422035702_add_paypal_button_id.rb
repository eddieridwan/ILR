class AddPaypalButtonId < ActiveRecord::Migration
  def self.up
    add_column :products, :paypal_button_id, :string
    add_column :products, :product_details, :text
  end

  def self.down
    remove_column :products, :paypal_button_id
    remove_column :products, :product_details
  end
end
