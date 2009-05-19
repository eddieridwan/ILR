class Payment < ActiveRecord::BaseWithoutTable
  require 'date'
  
  column :first_name, :string
  column :last_name, :string
  column :number, :string
  column :month, :integer
  column :year, :integer
  column :verification_value, :integer
  
  validates_presence_of :number, :verification_value, :month, :year
  validation_group :step1, :fields=>[:number, :verification_value, :month, :year]

  def years
    y = Array.new
    year = DateTime.now.year
    year.upto(year + 15) { |i| y << i}
    return y
  end
end
