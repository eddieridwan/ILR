class Product < ActiveRecord::Base
  has_many :line_items
  
  def self.find_products_for_sale
    find(:all, :order => "title" )
  end

  validates_presence_of :productid, :title, :description
  validates_uniqueness_of :productid, :title
    
end
