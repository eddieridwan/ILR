class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_address_1
      t.string :street_address_2
      t.string :city
      t.string :state
      t.string :postcode
      t.string :country
      t.string :email
      t.string :shipping_method
      t.decimal :shipping_cost, :precision => 8, :scale => 2
      t.decimal :tax, :precision => 8, :scale => 2
      t.decimal :order_total, :precision => 8, :scale => 2
      t.boolean :payment_status
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
