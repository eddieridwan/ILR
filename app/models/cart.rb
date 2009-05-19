class Cart
  attr_reader :items
  attr_accessor :read_only
  
  def initialize
    @items = []
    @read_only = false
  end
  
  def add_product(product)
    current_item = @items.find {|item| item.product == product}
    if current_item
      current_item.increment_quantity
    else
      current_item = CartItem.new(product)
      @items << current_item
    end
    current_item
  end
  
# not used
#  def update_item(product, quantity)
#    current_item = @items.find {|item| item.product == product}
#    current_item.quantity = quantity
#    current_item
#  end
  
  def remove_product(product)
    current_item = @items.find {|item| item.product == product}
    current_item.decrement_quantity
    if current_item.quantity == 0
      @items.delete(current_item)
    end
    current_item
  end

  def subtotal_price
    @items.sum { |item| item.price }
  end
  
  def total_items
    @items.sum { |item| item.quantity }
  end
  
end