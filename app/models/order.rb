class Order < ActiveRecord::Base
  include CountryType
  
  PAYMENT_TYPES = [
    # Displayed stored in db
    [ "Check" , "check" ],
    [ "Credit card" , "cc" ],
    [ "Purchase order" , "po" ]
  ]
  
  DOMESTIC_SHIPPING = [
    [ "Regular parcel", "d-std" ],
    [ "Express parcel", "d-exp" ]
  ]
  
  INTERNATIONAL_SHIPPING = [
    [ "Airmail", "i-air" ],
    [ "Courier", "i-courier"]
  ]
  
  validates_presence_of :first_name, :last_name, :street_address_1, :city, :country, :email
  validates_presence_of :shipping_method
  validates_presence_of :shipping_cost, :order_total
  validates_format_of :email,
   :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  
#  validates_inclusion_of :pay_type, :in =>
#    PAYMENT_TYPES.map {|disp, value| value}

  validation_group :step1, :fields=>[:first_name, :last_name, :street_address_1, :city, :country, :email]
  validation_group :step2, :fields=>[:shipping_method] 
  validation_group :step3, :fields=>[:shipping_cost, :order_total]

    
    # Validate email using ActiveMailer
#    email = OrderMailer.create_order_confirmation(@order)
#    if email.nil?
#      flash[:notice] = "There was an error in your email"
#    else



  has_many :line_items

  def add_line_items_from_cart(cart)
    # Delete existing line items in order
    self.line_items.clear
    # Replace with new ones from the cart
    cart.items.each do |item|
      li = LineItem.from_cart_item(item)
      line_items << li
    end
    # Also persists calculations
    self.shipping_cost = self.calc_shipping_cost(cart)
    self.order_total = self.calc_order_total(cart)
  end
  
  def calc_shipping_cost(cart)
    if self.shipping_method.nil? || self.shipping_method.empty?
      return nil
    end
    # Assume that products are limited to CDs
    # Later have to add weight for each product
    cart_weight = cart.total_items * 125 + 100 # in grams, incl packaging
    case self.shipping_method
    when "d-std"
      # Use Australia Post regular parcel tables (Mar 2009)
      case cart_weight
      # Using prepaid parcel post satchel
      when 000..500 then 5.50 + 2.50 
      when 501..3000 then 9.60 + 4.00
      else
        # Above 500g (without satchel), Australia Post charges are based on distance
        # The value used here is towards the upper range charge per part of kg
        # From Canberra, range is $0.50 to $3.10 per part kg
        9.05 + (Float(cart_weight) / Float(1000)).ceil * 2.50 + 5 
      end
    when "d-exp"
      # Use Australia Post express parcel tables (Mar 2009)
      case cart_weight
      # Fixed price up to 500gms
      when 000..500 then 7.70 + 2.50 
      else
        # Above 500g, Australia Post charges are based on distance
        # The value used here is towards the upper range charge per part of kg
        # From Canberra, range is $2.20 to $18.00 per part kg
        15.70 + (Float(cart_weight) / Float(1000)).ceil * 12.00 + 5 
      end
    when "i-air"
      # Use Australia Post international air parcel tables (Mar 2009)
      case cart_weight
      # Rate is determined by zone of destination country
      when 000..250 then INTERNATIONAL_AIRMAIL[0][ship_to_zone(self.country)] + 5
      when 251..500 then INTERNATIONAL_AIRMAIL[1][ship_to_zone(self.country)] + 5
      when 501..750 then INTERNATIONAL_AIRMAIL[2][ship_to_zone(self.country)] + 5
      when 751..1000 then INTERNATIONAL_AIRMAIL[3][ship_to_zone(self.country)] + 5
      when 1001..1250 then INTERNATIONAL_AIRMAIL[4][ship_to_zone(self.country)] + 5
      when 1251..1500 then INTERNATIONAL_AIRMAIL[5][ship_to_zone(self.country)] + 5
      when 1501..1750 then INTERNATIONAL_AIRMAIL[6][ship_to_zone(self.country)] + 5
      when 1751..2000 then INTERNATIONAL_AIRMAIL[7][ship_to_zone(self.country)] + 5
      else
        # Above 2000g, there is an incremental charge for extra 500g or part of
        INTERNATIONAL_AIRMAIL[7][ship_to_zone] + 
          (Float(cart_weight-2000) / Float(500)).ceil * INTERNATIONAL_AIRMAIL_INC[ship_to_zone(self.country)] + 5 
      end
    when "i-courier"
      # Use Australia Post Express Courier International air parcel tables (Mar 2009)
      case cart_weight
      # Rate is determined by zone of destination country
      when 000..500 then INTERNATIONAL_COURIER[0][ship_to_zone(self.country)] + 5
      when 501..1000 then INTERNATIONAL_COURIER[1][ship_to_zone(self.country)] + 5
      when 1001..2000 then INTERNATIONAL_COURIER[2][ship_to_zone(self.country)] + 5
      when 2001..3000 then INTERNATIONAL_COURIER[3][ship_to_zone(self.country)] + 5
      else
        # Above 3000g, raise an exception as unlikely to happen
        raise "Maximum for shipping by International Courier is 3kg"
      end
    else
      logger.error "Invalid shipping method: " + self.shipping_method
      raise "Invalid shipping method"
    end
  end
  
  def calc_order_total(cart)
    return calc_shipping_cost(cart) + cart.subtotal_price
  end

  def shipping_method_text
    if self.country == Order::COUNTRY_TYPES.assoc("Australia")[1]
      return Order::DOMESTIC_SHIPPING.rassoc(self.shipping_method)[0]
    else
      return Order::INTERNATIONAL_SHIPPING.rassoc(self.shipping_method)[0]
    end  
  end
  
  private
  
  def ship_to_zone(country)
    zone_index = {
      "A" => 0,
      "B" => 1,
      "C" => 2,
      "D" => 3
    }
    c = COUNTRY_TYPES.rassoc(country)[0] # Get country name
    if (z_entry = INTERNATIONAL_ZONES.assoc(c)) == nil
      # For countries not in the known list, assume Zone D
      z = zone_index["D"]
    else 
      z = zone_index[z_entry[1]]
    end
    logger.info "---------------------zone index---" + c + ":" + z.to_s
    return z
  end
  
  # Australia Post International Parcel zones
  INTERNATIONAL_ZONES = [
    ["Austria","D"],
    ["Belgium","D"],
    ["Canada","C"],
    ["China","B"],
    ["Denmark","D"],
    ["Fiji","B"],
    ["Finland","D"],
    ["France","D"],
    ["Germany","D"],
    ["Greece","D"],
    ["Hong Kong","B"],
    ["India","B"],
    ["Indonesia","B"],
    ["Ireland","D"],
    ["Israel","C"],
    ["Italy","D"],
    ["Japan","B"],
    ["Korea","B"],
    ["Malaysia","B"],
    ["Malta","D"],
    ["Netherlands","D"],
    ["New Caledonia","B"],
    ["New Zealand","A"],
    ["Norway","D"],
    ["Papua New Guinea","B"],
    ["Philippines","B"],
    ["Poland","D"],
    ["Singapore","B"],
    ["Solomon Islands","B"],
    ["South Africa","D"],
    ["Spain","D"],
    ["Sri Lanka","B"],
    ["Sweden","D"],
    ["Switzerland","D"],
    ["Taiwan","B"],
    ["Thailand","B"],
    ["United Kingdom","D"],
    ["United States","C"],
    ["Vietnam","B"]
  ]
  
  # Australia Post International Air Parcel (Mar 2009)
  # [ZoneA, ZoneB, ZoneC, ZoneD]
  INTERNATIONAL_AIRMAIL = [
    [6.85,7.95,9.05,10.70], # 0..250
    [10.45,12.65,14.85,18.15], # 251..500
    [14.05,17.35,20.65,25.60], # 501..750
    [17.65,22.05,26.45,33.05], # 751..1000
    [21.25,26.75,32.25,40.50], # 1001..1250
    [24.85,31.45,38.05,47.95], # 1251..1500
    [28.45,36.15,43.85,55.40], # 1501..1750
    [32.05,40.85,49.65,62.85] # 1751..2000
  ]
  INTERNATIONAL_AIRMAIL_INC = [
    [3.80,4.85,7.05,9.35] # Above 2000g
  ]
  
  # Australia Post Express Courier International (Mar 2009)
  # [ZoneA, ZoneB, ZoneC, ZoneD]
  INTERNATIONAL_COURIER = [
    [41.05,43.65,47.75,50.35], # 0..500
    [46.75,51.40,57.10,60.25], # 501..1000
    [54.55,60.75,69.05,76.35], # 1001..2000
    [62.85,74.25,86.75,94.55] # 2001..3000
  ]
end

