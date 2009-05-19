class CartItem
  attr_reader :product
  attr_accessor :quantity
  
  def initialize(product)
    @product = product
    @quantity = 1
  end
  
  def increment_quantity
    @quantity += 1 if @quantity < 9 # Currently not expecting orders of more than 9 per item
  end

  def decrement_quantity
    @quantity -= 1 if @quantity > 0
  end

  def title
    @product.title
  end
  
  def price
    @product.price * @quantity.to_i
  end
end