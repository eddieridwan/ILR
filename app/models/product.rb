class Product < ActiveRecord::Base
  has_many :line_items
  
  def self.find_products_for_sale (category)
    if (category.present?)
      find(:all, :conditions => {:category => category.downcase}, :order => "title" )
    else
      find(:all, :order => "title")
    end
  end

  validates_presence_of :productid, :title, :description
  validates_uniqueness_of :productid, :title

  validation_group :step1, :fields=>[:all]

end
