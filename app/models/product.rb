class Product < ActiveRecord::Base
  has_many :line_items
  
  named_scope :in_stock, :conditions => { :in_stock => true }
  
  def self.find_products_for_sale (category)
    if (category.present?)
      in_stock.find(:all, :conditions => {:category => category.downcase}, :order => "title" )
    else
      in_stock.find(:all, :order => "title")
    end
  end

  validates_presence_of :productid, :title, :description
  validates_uniqueness_of :productid, :title

  validation_group :step1, :fields=>[:all]

end
