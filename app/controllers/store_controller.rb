class StoreController < ApplicationController
  include ActionView::Helpers::NumberHelper
  protect_from_forgery :except => :process_order
  
  def shop
    @products = Product.find_products_for_sale
    @cart = find_cart
    @title = "Indonesian Language Resources Online Shop"
    @showbuttons = true
    @order = find_order
  end
  
  def index
    @title = "Indonesian Language Resources"
  end
  
  def contact 
    @title = "Indonesian Language Resources Contacts"
  end

  def privacy
    @title = "Indonesian Language Resources Privacy Policy"
  end

  def add_to_cart
    product = Product.find(params[:id])
    @showbuttons = true
    @cart = find_cart
    @current_item = @cart.add_product(product)
    @order = find_order
    respond_to do |format|
      format.js if request.xhr?
      format.html { redirect_to_index }
    end
  rescue ActiveRecord::RecordNotFound
    logger.error("Attempt to access invalid product #{params[:id]}" )
    redirect_to_index("Invalid product")
  end

# Not used
#  def update_cart_item
#    @cart = find_cart
#    product = Product.find(params[:id])
#    quantity = params[:cart_item][:quantity]
#    
#    @current_item = @cart.update_item(product, quantity)
#    logger.info "----title-------------" + @current_item.title
#    logger.info "----quantity----------" + @current_item.quantity
#    logger.info number_to_currency(@current_item.price)
#    redirect_to_index
#  end
  
  def remove_from_cart
    @showbuttons = true
    begin
      product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to access invalid product #{params[:id]}")
      redirect_to_index("Invalid product" )
    else
      @cart = find_cart
      @current_item = @cart.remove_product(product)
      @order = find_order
      respond_to do |format|
        format.js if request.xhr?
        format.html {redirect_to_index}
      end
    end
  end

  
  def empty_cart
    session[:cart] = nil
    redirect_to_index
  end
  
  def product_details
    @product = Product.find(params[:id])
    @title = @product.title
    @cart = find_cart
    @showbuttons = true
    @order = find_order
  end

  def checkout
    # View sequence: [1] address --> [2] shipping method --> [3] confirmation --> [4] payment @PayPal
    # This action is [1]

    # Clear errors if this view is not redirected from checkout_shipping, 
    # where the form validation was triggered
    if session[:came_from] == nil or session[:came_from] != "address_validation"
      @order = find_order
      @order.errors.clear
    end
    
    session[:came_from] = "checkout"
    @title = "Indonesian Language Resources Checkout"
    @cart = find_cart
    if @cart.items.empty?
      redirect_to_index("Your cart is empty" )
    else
      @order = find_order
    end
  end

  def checkout_shipping
    # View sequence: [1] address --> [2] shipping method --> [3] confirmation --> [4] payment @PayPal
    # This action is [2]

    # Check cart in case user directly accessed url
    @cart = find_cart
    if @cart.items.empty?
      redirect_to_index("Your cart is empty" )
      return
    end

    # Validate the order data entered in the checkout form
    # Go back to the checkout form if data is not valid
    if session[:came_from] == "checkout"
      order = Order.new(params[:order])
      @order = session[:order]
      # Update order fields set in previous form to session
      # Should do this a bit safer, defining the fields set in each view in the Order model
      [:first_name, :last_name, :street_address_1, :street_address_2, :city, :state, :postcode, :country, :email].each do |attr|
        @order[attr] = order[attr]
        session[:order] = @order
      end 
      @order.enable_validation_group :step1
      if @order.valid? == false
        session[:came_from] = "address_validation"
        redirect_to :action => 'checkout'
        return
      end
    end

    # For all paths including redirects from other checkout forms
    session[:came_from] = "checkout_shipping"
    @title = "Indonesian Language Resources Checkout"
    @order = session[:order]
    if @order.country == Order::COUNTRY_TYPES.assoc("Australia")[1]
      @shipping_type = "Domestic"
      @shipping_options = Order::DOMESTIC_SHIPPING
    else
      @shipping_type = "International"
      @shipping_options = Order::INTERNATIONAL_SHIPPING
    end
  end

  def checkout_review
    # View sequence: [1] address --> [2] shipping method --> [3] confirmation --> [4] payment @PayPal
    # This action is [3]

    # Check cart in case user directly accessed url   
    @cart = find_cart
    if @cart.items.empty?
      redirect_to_index("Your cart is empty" )
      return
    end
    
    @order = find_order
    if @order.nil?
      flash[:notice] = "Please complete your order details"
      redirect_to :action => 'checkout'
      return
    end

    # Validate the order data entered in the checkout_shipping form
    # Go back to the checkout_shipping form if data is not valid
    if session[:came_from] == "checkout_shipping"
      # Update session order fields with values set in previous form
      # Should do this a bit safer, defining the fields set in each view in the Order model
      order = Order.new(params[:order])
      @order = session[:order]
     [:shipping_method].each do |attr|
        @order[attr] = order[attr]
        session[:order] = @order
      end 
      @order.enable_validation_group :step2
      if @order.valid? == false
        session[:came_from] = "shipping_validation"
        redirect_to :action => 'checkout_shipping'
        return
      end
    end

    # Final check of order and save to database
    # Go back to the checkout form if data is not valid
    # Would only happen if user went directly to this view
    # @TODO should look at configuring routes.rb to specify what urls should not be accessible
    # Because the user can freely go to previous edit screens, it is possible that
    # the order has already been persisted
    delete_order_line_items(@order) # delete existing persisted line items for the order
    @order.add_line_items_from_cart(@cart) # Also persists calculations
    if @order.save == false
      session[:came_from] = "address_validation"
      redirect_to :action => 'checkout'
      return
    end

    # Main path
    @title = "Indonesian Language Resources Checkout"
    # Show the cart in readonly mode
    @cart.read_only = true # For this rendering only; reset in find_cart
  end

  def mock_paypal
    # View sequence: [1] address --> [2] shipping method --> [3] confirmation --> [4] payment @PayPal
    # This action is a mockup for [4]

    # Pass parameters to the mock view   
    @paypal_parameters = params
  end

  # POST /store/process_order from PayPal payment
  def process_order
    payment_ok = true
    # Check authenticity token sent to PayPal
#    if params[:custom] != form_authenticity_token
#      logger.info("Invalid authenticity token from paypal = " + params[:custom])
#      payment_ok = false
#    end
#    if params[:payment_status] != "Completed"
    if params[:st] != "Completed"
      logger.info("Payment status not completed = " + params[:st])
      payment_ok = false
    end
    logger.info("PayPal transaction = " + params[:tx])
    # If payment not successful, delete saved order and display error message
    @order = find_order
    if !payment_ok
      order = Order.find(@order.id)
      order.destroy
      flash[:notice] = "Payment was not successful. Please try again"
      redirect_to :action => 'shop'
      return
    end
  
    # If payment successful, record on order
    # and send invoice
     
    @title = "Indonesian Language Resources Checkout"
    @cart = find_cart

    # Set order flag to say that payment has been completed
    @order.update_attribute("payment_status", true)
    
    # Compile receipt to display
    # Email the receipt to customer
    # Email the order to languagetechnologies.com
    email = OrderMailer.create_order_confirmation(@order)
    email.to.each do |e|
      logger.info("---------- mail.to " + e)
    end
    @order_confirmation = email
    Thread.new(email) do |e|
      OrderMailer.deliver(email)
    end

    # Clean up session data
    session[:cart] = nil
    session[:order] = nil
    session[:payment] = nil
    session[:came_from] = nil
    @cart = nil # provide empty cart to view
  end
  
#  def cancel_order
#    session[:order] = nil
#    session[:payment] = nil
#    redirect_to_index("Order details has been cleared")
#  end

  private
  
  def redirect_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to :action => 'shop'
  end
  
  def find_cart
    cart = session[:cart] ||= Cart.new
    cart.read_only = false # reset to enable remove item button
    return cart
  end

  def find_order
    session[:order] ||= Order.new
  end

  def find_payment
    session[:payment] ||= Payment.new
  end
  
  def delete_order_line_items(order)
    o = Order.find(order.id)
    # Delete all the persisted line items
    o.line_items.each do |li|
      li.destroy
    end
  rescue
    $stderr.print $!
  end

protected
  def authorize
  end

end
