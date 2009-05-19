class OrderMailer < ActionMailer::Base
  

  def order_confirmation(order)
    subject    'Your order from Indonesian Language Resources'
    recipients order.email
#    cc         'eddie.ridwan@zoominti.com'
    bcc        'sales@languagetechnologies.com'
    from       'sales@languagetechnologies.com'
    sent_on    Time.now

    body       :order => order, :date_ordered => Time.now
  end

end
