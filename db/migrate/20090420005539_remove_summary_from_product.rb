class RemoveSummaryFromProduct < ActiveRecord::Migration
  def self.up
    remove_column :products, :summary
  end

  def self.down
    add_column :products, :summary, :text
  end
end
