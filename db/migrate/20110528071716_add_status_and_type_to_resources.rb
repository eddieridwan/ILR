class AddStatusAndTypeToResources < ActiveRecord::Migration
  def self.up
    add_column :resources, :status, :string
    add_column :resources, :type, :string
  end

  def self.down
    remove_column :resources, :status
    remove_column :resources, :type
  end
end
