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

  def resource_added(resource, request)
    subject       'A resource has been added to Indonesian Language Resources'
    recipients    %w(info@languagetechnologies.com)
    from          'admin@languagetechnologies.com'
    sent_on       Time.now

    body          :resource => resource, :date_added => Time.now, :request => request
    content_type  "text/html"
  end

end
