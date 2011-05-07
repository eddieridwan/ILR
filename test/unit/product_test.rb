require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "invalid with empty attributes" do
    product = Product.new
    assert !product.valid?
    assert product.errors.invalid?(:title)
    assert product.errors.invalid?(:description)
    assert product.errors.invalid?(:productid)
  end
  
  test "unique title" do
    product = Product.new(:title => products(:one).title,
      :description => "This is a sample description" ,
      :productid => '2222')
    assert !product.save
    assert_equal "has already been taken" , product.errors.on(:title)
  end
end
